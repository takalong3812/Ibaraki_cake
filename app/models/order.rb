class Order < ApplicationRecord
    
     has_many :order_details, dependent: :destroy
    belongs_to :user
    
    validates :postal_code, presence: true
    validates :address, presence: true
    validates :name, presence: true
    validates :way_of_paying, presence: true
    
    def with_tax_price
   (price*1.1).floor
    end
    
    enum way_of_paying: { credit_card:0, transfer:1 }
    
    enum recieve_status:{ not_yet:0, waiting:1, working:2, complete:3}
    
    


end
