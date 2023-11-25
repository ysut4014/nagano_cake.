class CreateCartItems < ActiveRecord::Migration[6.1]
  def change
    create_table :cart_items do |t|
      t.integer :item_id, null: false
      t.foreign_key :items, column: :item_id
      t.integer :customer_id, null: false
      t.foreign_key :customers, column: :customer_id
      
      t.integer :amount, null: false
      t.timestamps
    end
  end
end
