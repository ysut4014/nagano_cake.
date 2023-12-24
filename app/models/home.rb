class Home < ApplicationRecord
  validates :address, presence: true
  validates :rooms, numericality: { only_integer: true, greater_than: 0 }
  validates :price, numericality: { greater_than_or_equal_to: 0 }
  
    belongs_to :item


end