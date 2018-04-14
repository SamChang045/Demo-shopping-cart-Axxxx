class ProductsController < ApplicationController

  before_action :authenticate_user!
  
  def index
    @products = Product.page(params[:page]).per(10)
    @cart_items = current_cart.cart_items.all    
    @subtotal = 0
    session[:form_data] = nil
  end

  def show
    @product = Product.find(params[:id])
    @cart_items = current_cart.cart_items.all
    @subtotal = 0
    @add_quantity = 1
  end

  def add_to_cart
    @product = Product.find(params[:id])
    @cart_item = current_cart.add_cart_item(@product)
    if params[:current_quantity] != nil 
      @cart_item.quantity +=params[:current_quantity].to_i-1
    end
    @cart_item.save!
    render :json => {:id => @product.id, :name => @product.name, :quantity => @cart_item.quantity, :price => @product.price}
  end
  
end
