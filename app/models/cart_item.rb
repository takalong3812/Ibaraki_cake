class CartItem < ApplicationRecord


 belongs_to :user
 belongs_to :item
 
 def with_tax_price
   (price*1.1).floor
 end
 
  #小計
 def subtotal
     item.with_tax_price*amount
 end
    
end
