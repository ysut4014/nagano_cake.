module Public::OrdersHelper
  def change_price(price)
    ((price * 1.1).round(2)).round
  end
end