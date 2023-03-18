class Admin::OrdersController < ApplicationController
    
  before_action :authenticate_admin!

  def index
    @orders = Order.all
  end

  def show
    @order = Order.find(params[:id])
   
  end
  
  
  private

  def order_params
    params.require(:order).permit(:order_status)
  end
    
end
