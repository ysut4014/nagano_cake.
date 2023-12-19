# db/migrate/xxxxxx_add_address_number_to_orders.rb

class AddAddressNumberToOrders < ActiveRecord::Migration[6.0]
  def change
    add_column :orders, :address_number, :integer
  end
end
