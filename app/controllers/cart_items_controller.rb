class CartItemsController < ApplicationController
  
  def index
      @cart_items = current_cart.cart_items.all
      @subtotal =0
      if session[:form_data].present?
        @order = Order.new(session[:form_data])
      else
        @order = Order.new
      end     
  end

  def plus_quantity
    @cart_item = current_cart.cart_items.find_by(product_id: params[:id])
    @cart_item.quantity+=1
    @cart_item.save!
    render :json => {:id =>params[:id] , :quantity => @cart_item.quantity, :price => @cart_item.product.price}
  end


  def minus_quantity
    @cart_item = current_cart.cart_items.find_by(product_id: params[:id])
    if @cart_item.quantity>0
      @cart_item.quantity -=1
      @cart_item.save!
      render :json => {:id =>params[:id] , :quantity => @cart_item.quantity, :price => @cart_item.product.price}
    else
      render :json => {:id =>params[:id] , :quantity => 0 }
    end
  end

  def destroy
    @cart_item = current_cart.cart_items.find_by(product_id: params[:id])
    @minus_price = @cart_item.quantity * @cart_item.product.price
    @cart_item.destroy
    render :json => {:id =>params[:id], :minus_price => @minus_price}
  end

end