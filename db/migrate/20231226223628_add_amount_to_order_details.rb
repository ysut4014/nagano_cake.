# 20231226223628_add_amount_to_order_details.rb

class AddAmountToOrderDetails < ActiveRecord::Migration[6.1]
  def change
    add_column :orders_details, :amount, :integer
  end
end
