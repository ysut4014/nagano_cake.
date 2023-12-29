class RemoveQuantityFromOrderDetails < ActiveRecord::Migration[6.1]
  def change
    remove_column :order_details, :quantity
  end
end
