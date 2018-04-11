class Admin::ProductsController < ApplicationController

  before_action :authenticate_user!
  before_action :authenticate_admin

  def index
    @products = Product.all
  end
  
  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      flash[:notice] = "product was successfully created"
      redirect_to admin_products_path
    else
      flash.now[:alert] = "product was failed to create"
      render :new
    end
  end

  def show
    @product = Product.find(params[:id])
  end

  private

  def restaurant_params
    params.require(:product).permit(:name, :description, :price)
  end

end
