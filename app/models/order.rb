class Order < ApplicationRecord

  VALID_POSTAL_CODE_REGEX = /\A\d{7}\z/

  validates :total_price, presence: true
  validates :payment_method, presence: true
  validates :shipping_fee, presence: true
  validates :address, length: { in: 1..48 }
  validates :postal_code, format: { with: VALID_POSTAL_CODE_REGEX }
  validates :name, length: { in: 1..32 }
  validates :status, presence: true

  has_many :order_details, dependent: :destroy
  belongs_to :customer
  has_many :items, through: :order_details
  
  

  enum payment_method: {クレジットカード:0, 銀行振込:1}
  enum status: {入金待ち:0, 入金確認:1, 製作中:2, 発送準備中:3, 発送済み:4}

  def temporary_information_input(current_customer_id)
    self.customer_id = current_customer_id
    self.shipping_fee = 800
    self.total_price = 1
  end  
  
  def order_in_address_display(postal_code, address, name)
    self.postal_code = postal_code
    self.address = address
    self.name = name
  end
  
 
end