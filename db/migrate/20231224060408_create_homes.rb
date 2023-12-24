class CreateHomes < ActiveRecord::Migration[6.0]
  def change
    create_table :homes do |t|
      t.string :address
      t.integer :rooms
      t.decimal :price, precision: 8, scale: 2

      t.timestamps
    end
  end
end