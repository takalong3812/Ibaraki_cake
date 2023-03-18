class Public::OrdersController < ApplicationController
    
   def new
     @order = Order.new     
     @credit_card = Order.way_of_payings.key(0)
     @transfer = Order.way_of_payings.key(1)
     @credit_card_ja = Order.way_of_payings_i18n[:credit_card]
     @transfer_ja = Order.way_of_payings_i18n[:transfer]
   end 
    
end
