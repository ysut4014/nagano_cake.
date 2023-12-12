class AddItemIdToOtherModelRecords < ActiveRecord::Migration[6.1]
  def change
    add_reference :other_model_records, :item, null: false, foreign_key: true
  end
end
