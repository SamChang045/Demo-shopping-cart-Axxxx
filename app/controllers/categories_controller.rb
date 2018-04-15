class CategoriesController < ApplicationController

  def index
    @products = Product.page(params[:page]).per(9)
    @categories = Category.all     # 加上這一行
  end

  def show
    @categories = Category.all
    @category = Category.find(params[:id])
    @products = @category.products.page(params[:page]).per(9)
  end

end
