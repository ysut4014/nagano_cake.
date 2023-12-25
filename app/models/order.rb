class Order < ApplicationRecord

  belongs_to :customer
  has_many :order_details, dependent: :destroy
  has_many :cart_items
  has_many :items, through: :order_details
  

  
  def self.ransackable_attributes(auth_object = nil)
    ["address", "address_id", "address_number", "created_at", "customer_id", "id", "name", "payment_method", "postal_code", "shipping_fee", "status", "total_price", "updated_at"]
  end
  enum payment_method: { "クレジットカード": 0, "銀行振込": 1 }
  enum status: { "入金待ち": 0, "入金確認": 1, "製作中": 2, "発送準備中": 3, "発送済み": 4 }
  
  
end