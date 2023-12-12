class CreateOtherModelRecords < ActiveRecord::Migration[6.1]
  def change
    create_table :other_model_records do |t|
      # Add your other_model_record attributes here
      t.string :name
      t.integer :quantity
      # ...

      t.timestamps
    end
  end
end