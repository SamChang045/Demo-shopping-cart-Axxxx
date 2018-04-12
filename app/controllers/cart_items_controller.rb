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

end
