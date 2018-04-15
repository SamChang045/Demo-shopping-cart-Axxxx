class Admin::ProductsController < ApplicationController

  def index 
    @products = Product.page(params[:page]).per(10)
    @product = Product.new
    
  end

  def edit
    @product =Product.find(params[:id])
  end

  def destroy
    @product = Product.find(params[:id])
    @product.destroy
    flash[:alert] = "product was successfully deleted"
    redirect_back(fallback_location: admin_root_path)
  end

  def create
    @product = Product.new(product_params)
    if @product.save
       flash[:notice] = "product was successfully created"
      redirect_to admin_root_path
    else
      flash.now[:alert] = "restaurant was failed to created"
      render :index
    end
  end

  private 

  def product_params
    params.require(:product).permit(:name, :description, :price, :image, :category_id)
  end

end
