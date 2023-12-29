class CartItem < ApplicationRecord
  validates :amount, numericality: { only_integer: true, greater_than: 0, less_than: 1000 }

  belongs_to :customer
  belongs_to :item
  
  def subtotal#小計
    item.with_tax_price * amount
  end

end