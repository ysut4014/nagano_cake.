class RenameIsActiveToIsSoldOutInItems < ActiveRecord::Migration[6.1]
  def change
    rename_column :items, :is_active, :is_sold_out
  end
end
