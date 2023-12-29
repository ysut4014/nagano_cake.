class RenameOrdersDetailsToOrderDetails < ActiveRecord::Migration[6.1]
  def change
    rename_table :orders_details, :order_details
  end
end