class Admin::ProductsController < ApplicationController

  before_action :authenticate_user!
  before_action :authenticate_admin
  before_action :set_product, only: [:show, :edit, :update]

  def index
    @products = Product.page(params[:page]).per(10)
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

  def update
    if @product.update(product_params)
      flash[:notice] = "product was successfully updated"
      redirect_to admin_product_path(@product)
    else
      flash.now[:alert] = "product was failed to update"
      render :edit
    end
  end

  def destroy
    @product.destroy
    redirect_to admin_products_path
    flash[:alert] = "product was deleted"
  end

  private

  def set_product
    @product = Product.find(params[:id])
  end

  def restaurant_params
    params.require(:product).permit(:image, :name, :description, :price)
  end

end
