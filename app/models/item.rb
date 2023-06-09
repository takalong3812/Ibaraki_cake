class Item < ApplicationRecord
  
  
 has_many :cart_items, dependent: :destroy 
  
    
 belongs_to :genre
 has_one_attached :image
 
  
  validates :name, presence: true
  validates :price, presence: true

def with_tax_price
   (price * 1.1).floor
end

end
