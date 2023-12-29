class Address < ApplicationRecord
   belongs_to :customer
   
def address_display
  '〒' + postal_code + ' ' + address + ' ' + name
end   

  def postal_code_and_address_and_name
    "#{postal_code} #{address} #{name}"
  end
  
  
end
