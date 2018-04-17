class Admin::OrdersController < ApplicationController

  def index
    @orders = Order.page(params[:page]).per(10)
  end

  def edit
    @order = Order.find(params[:id])
  end

  def update
    @order = Order.find(params[:id])
    @order.shipping_status = params[:shipping_status]
    @order.payment_status =params[:payment_status]
    @order.save!
    redirect_to admin_orders_path
  end
  
end
