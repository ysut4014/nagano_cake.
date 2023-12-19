class Public::OrdersController < ApplicationController
  
  def show
    @order = Order.find_by(id: params[:id])

    if @order.nil?
      flash[:alert] = '指定された注文が見つかりませんでした。'
      redirect_to root_path # またはエラーページなどへのリダイレクト
    end
  end

  # 他のアクションの定義...
def new
		    @order = Order.new

end
def log
  @order = Order.new(order_params)
  @order.customer_id = current_customer.id

  if current_customer.address.present?
    @order.address = current_customer.address
  else
    Rails.logger.debug("Current customer address is nil.")
  end

  # Assign @cart_items properly
  @cart_items = current_customer.cart_items || []

  # Calculate @total
  @total = 0
  @cart_items.each do |cart_item|
    @total += (cart_item.item.price * 1.1 * cart_item.amount).floor
  end

  # Use @order.address directly in the view
end






	def create
	  @order = Order.new
		@customer = current_customer

		# sessionを使ってデータを一時保存
		session[:order] = Order.new

		cart_items = current_customer.cart_items

		# total_paymentのための計算
		sum = 0
		cart_items.each do |cart_item|
			sum += (cart_item.item.price_without_tax * 1.1).floor * cart_item.amount
		end

		session[:order][:shipping_fee] = 800
		session[:order][:total_price] = sum + session[:order][:shipping_fee]
		session[:order][:status] = 0
		session[:order][:customer_id] = current_customer.id
		# ラジオボタンで選択された支払方法のenum番号を渡している
		session[:order][:payment_method] = params[:method].to_i

		# ラジオボタンで選択されたお届け先によって条件分岐
		destination = params[:a_method].to_i

# ご自身の住所が選択された時
if destination == 0
  session[:order][:postal_code] = @customer.postal_code
  session[:order][:address] = @customer.address
  session[:order][:name] = @customer.last_name + @customer.first_name

# 登録済住所が選択された時
elsif destination == 1
  address = ShippingAddress.find(params[:shipping_address_for_order])
  session[:order][:postal_code] = address.postal_code
  session[:order][:address] = address.address
  session[:order][:name] = address.name 

# 新しいお届け先が選択された時
elsif destination == 2
  session[:new_address] = 2
  session[:order][:postal_code] = params[:postal_code]
  session[:order][:address] = params[:address]
  session[:order][:name] = params[:name]
end

		# お届け先情報に漏れがあればリダイレクト
    if session[:order][:postal_code].presence && session[:order][:address].presence && session[:order][:name].presence
      redirect_to new_customer_order_url(customer_id: @customer.id)
    else
      redirect_to customers_orders_about_path
    end

	end

def order_params
  params.require(:order).permit(:payment_method, :address_number, :address_id, :postal_code, :name)
end
end
