class Item < ApplicationRecord
    has_one_attached :image
   
    belongs_to :genre
    
    has_many :other_model_records, dependent: :destroy
    
    def with_tax_price
     (price * 1.1).floor
    end


end
