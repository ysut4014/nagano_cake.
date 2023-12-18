# db/migrate/xxxxxx_change_shipping_id_to_shipping_fee_in_orders.rb

class ChangeShippingIdToShippingFeeInOrders < ActiveRecord::Migration[6.1]
  def change
    # 新しいカラムを追加
    add_column :orders, :shipping_fee, :integer, null: false

    # 旧いカラムのデータを新しいカラムにコピー
    Order.find_each do |order|
      order.update(shipping_fee: calculate_shipping_fee(order.shipping_id))
    end

    # 旧いカラムを削除
    remove_column :orders, :shipping_id
  end

  # shipping_feeの計算ロジック
  def calculate_shipping_fee(shipping_id)
    # ここにshipping_feeの計算ロジックを実装
  end
end
