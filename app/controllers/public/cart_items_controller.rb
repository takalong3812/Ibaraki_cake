class Public::CartItemsController < ApplicationController
  
  before_action :authenticate_user!
    
  def index
    @cart_items = CartItem.all
     @total = @cart_items.inject(0) { |sum, item| sum + item.subtotal }
  end
  
  def create
    @cart_item= CartItem.new(cart_item_params)
    @cart_item.user_id= current_user.id
    @cart_item.save
    redirect_to public_cart_items_path
  end 
  
  def update
    @cart_item= CartItem.find(params[:id])
    @cart_item.update(cart_item_params)
    redirect_to request.referer
  end 
  
  def destroy
    @cart_item= CartItem.find(params[:id])
    @cart_item.destroy
    redirect_to request.referer
  end
  
  def destroy_all
    @cart_items= CartItem.all
    @cart_items.destroy_all
    redirect_to request.referer
  end
  
    


  private
 
  def cart_item_params
      params.require(:cart_item).permit(:item_id, :amount)
  end      
    
    
    
end
