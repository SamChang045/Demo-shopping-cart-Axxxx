class Admin::CategoriesController < ApplicationController

  before_action :authenticate_user!
  before_action :authenticate_admin

  def index
    @categories = Category.all
    # 這裡是new or edit 的form所需要的值，如果有url有id就將form帶入edit，沒有就new。
    if params[:id]
      @category = Category.find(params[:id])
    else
      @category = Category.new
    end
  end

  def create
   @category = Category.new(category_params)
   if @category.save
     flash[:notice] = "category was successfully created"
     redirect_to admin_categories_path
   else
     @categories = Category.all
     render :index
   end
  end

  def update
    @category = Category.find(params[:id])
    if @category.update(category_params)
      flash[:notice] = "category was successfully updated"
      redirect_to admin_categories_path
    else
      @categories = Category.all
      render :index
    end
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end

end
