class AddAmountToOrderDetails < ActiveRecord::Migration[6.0]
  def change
    change_column :order_details, :amount, :integer, null: false
  end
end