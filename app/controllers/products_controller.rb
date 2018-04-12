class ProductsController < ApplicationController

  before_action :authenticate_user!
  
  def index
    @products = Product.page(params[:page]).per(9)
   end
  
  def add_to_cart
    @product = Product.find(params[:id])
    current_cart.add_cart_item(@product)

    redirect_to root_path
  end
  
end
