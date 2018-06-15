class OrdersController < ApplicationController

  def index
    @orders = Order.all
  end

  def create
    if current_user.nil?
      session[:form_data] = params[:order]
      redirect_to new_user_session_path
    else
      @order = Order.new(order_params)
      @cart_items = current_cart.cart_items.all
      @order.user_id = current_user.id
      @order.sn = 1000000 + Order.count
      @order.payment_status = "not_paid"
      @order.shipping_status = "not_shipped"
      @order.email = current_user.email
      @order.amount = 0
      if @order.save
        @cart_items.each do |item|
          order_item = @order.order_items.build(product_id: item.product.id, price: item.product.price, quantity: item.quantity)
          @order.amount += item.product.price * item.quantity
          order_item.save!
        end
        @order.save!  
        #UserMailer.notify_order_create(@order).deliver_now! #寄送訂單成立email
        session[:cart_id] = nil #訂單成立清空購物車
        redirect_to order_path(@order)
      else
        @subtotal =0;
        flash[:alert] = @order.errors.full_messages.to_sentence
        render 'cart_items/index.html.erb'
      end  
    end 
  end


  def show
    @order = Order.find(params[:id])   
  end

  def destroy
    @order= Order.find(params[:id])
    if @order.shipping_status == "not_shipped"
      @order.destroy
      redirect_to orders_path
      flash[:notice] = "Order was successfully canceled"
    else
      render :index
      flash[:alert] = "Not allow! Order was shipping"
    end  
  end

  def checkout_spgateway
    @order = current_user.orders.find(params[:id])
    if @order.payment_status != "not_paid"
      flash[:alert] = "Order has been paid."
      redirect_to orders_path
    else
      @payment = Payment.create!(
        sn: Time.now.to_i,
        order_id: @order.id,
        amount: @order.amount
      )

      spgateway_data = {
        MerchantID: "MS34023486",
        Version: 1.4,
        RespondType: "JSON",
        TimeStamp: Time.now.to_i,
        MerchantOrderNo: "#{@payment.id}AC",
        Amt: @order.amount,
        ItemDesc: @order.name,
        ReturnURL: spgateway_return_url,
        Email: @order.user.email,
        LoginType: 0
      }.to_query

      hash_key = "prH3YL5mWBqiDHxB77g8ViCpi0rNjA89"
      hash_iv = "RJQ6xs6Fttyu0I9I"

      cipher = OpenSSL::Cipher::AES256.new(:CBC)
      cipher.encrypt
      cipher.key = hash_key
      cipher.iv  = hash_iv
      encrypted = cipher.update(spgateway_data) + cipher.final
      aes = encrypted.unpack('H*').first    # binary 轉 hex

      str = "HashKey=#{hash_key}&#{aes}&HashIV=#{hash_iv}"
      sha = Digest::SHA256.hexdigest(str).upcase

      @merchant_id = "MS34023486"
      @trade_info = aes
      @trade_sha = sha
      @version = "1.4"
      
      render layout: false
    end
  end

  def order_params
    params.require(:order).permit(:name, :phone, :address)
  end

end
