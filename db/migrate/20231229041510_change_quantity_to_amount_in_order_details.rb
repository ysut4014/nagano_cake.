class ChangeQuantityToAmountInOrderDetails < ActiveRecord::Migration[6.1]
  def change
    # この行をコメントアウトまたは削除してください
    # rename_column(:order_details, :quantity, :amount)
    change_column(:order_details, :quantity, :integer) # quantity カラムの型を変更
  end
end