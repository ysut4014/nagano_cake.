class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|
      t.integer :customer_id, null: false
      t.foreign_key :customers, column: :customer_id
      t.integer :shipping_id, null: false
      t.text :address, null: false
      t.string :postal_code, null: false
      t.string :name, null: false
      t.integer :total_price, null: false
      t.integer :status, null: false, default: 0
      t.integer :payment_method, null: false, default: 0

      t.timestamps
    end
  end
end
