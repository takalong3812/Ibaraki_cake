class Public::OrdersController < ApplicationController
    
   def new
     @order = Order.new     
     @credit_card = Order.way_of_payings.key(0)
     @transfer = Order.way_of_payings.key(1)
     @credit_card_ja = Order.way_of_payings_i18n[:credit_card]
     @transfer_ja = Order.way_of_payings_i18n[:transfer]
   end
   
   def confirm
   
    @cart_items= CartItem.all   
    @order=Order.new(order_params)
    @order.shipping_fee = 800
    @total_price_except_shipping_fee= @cart_items.inject(0) {|sum,item|sum + item.subtotal}
    @billing_amount= @total_price_except_shipping_fee + @order.shipping_fee
    
    

    if params[:order][:select_address] == "0"
      @order.postal_code = current_user.postal_code
      @order.address = current_user.address
      @order.name = current_user.last_name+current_user.first_name
    
    elsif  params[:order][:select_address] == "1"
      @addresses = Address.find(params[:order][:address_id])
      @order.postal_code = @addresses.postal_code
      @order.address = @addresses.address
      @order.name = @addresses.name
      
    else params[:order][:select_address] == "2"
    end
     
    
   end
    
   
   def create
     @order= Order.new(order_params)
     @order.user_id= current_user.id
     @order.save
     @cart_items= CartItem.all
     
    @cart_items.each do |item|
      @item= OrderDetail.new
      @item.item_id= item.item_id
      @item.amount= item.amount
      @item.purchase_price= item.item.with_tax_price
      @item.order_id= @order.id 
      @item.production_status= 'not_yet'
      @item.save
      
      
       @cart_items.destroy_all
       redirect_to public_orders_thanks_path
    end
   end    
   
   
   
   def index
    @orders= Order.all
    
   end
   
   def show
      @order= Order.find(params[:id])
   end
   
   def thanks
   end
   
   
   
   
  private

  def order_params
    params.require(:order).permit(:user_id, :shipping_fee, :billing_amount, :recieve_status, :postal_code, :address, :name, :way_of_paying)
  end
  
end
   
   
   
    
    
