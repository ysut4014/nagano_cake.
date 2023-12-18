class Public::OrdersController < ApplicationController
  
  def show
    @order = Order.find(params[:id])
  end  
	def new
		    @order = Order.new

	end
  
def log
  @order = Order.new(order_params)
  @total = 0
   @cart_items = current_customer.cart_items
    params[:order][:payment_method] = params[:order][:payment_method].to_i #payment_methodの数値に変換
    @order = Order.new(order_params) #情報を渡している
  #分岐
    if params[:order][:address_number] == "1" #address_numberが　”1”　なら下記　ご自身の住所が選ばれたら
      @order.postal_code = current_customer.postal_code #自身の郵便番号をorderの郵便番号に入れる
      @order.address = current_customer.address #自身の住所をorderの住所に入れる
      @order.name = current_customer.last_name+current_customer.first_name #自身の宛名をorderの宛名に入れる

    elsif  params[:order][:address_number] ==  "2" #address_numberが　”2”　なら下記　登録済からの選択が選ばれたら
      @order.postal_code = Address.find(params[:order][:address]).postal_code #newページで選ばれた配送先住所idから特定して郵便番号の取得代入
      @order.address = Address.find(params[:order][:address]).shipping_address #newページで選ばれた配送先住所idから特定して住所の取得代入
      @order.name = Address.find(params[:order][:address]).name #newページで選ばれた配送先住所idから特定して宛名の取得代入

    elsif params[:order][:address_number] ==  "3" #address_numberが　”3”　なら下記　新しいお届け先が選ばれたら
      @address = Address.new() #変数の初期化
      @address.shipping_address = params[:order][:shipping_address] #newページで新しいお届け先に入力した住所を取得代入
      @address.name = params[:order][:name] #newページで新しいお届け先に入力した宛名を取得代入
      @address.postal_code = params[:order][:postal_code] #newページで新しいお届け先に入力した郵便番号を取得代入
      @address.member_id = current_member.id #newページで新しいお届け先に入力したmember_idを取得代入
      if @address.save #保存
      @order.postal_code = @address.postal_code #上記で代入された郵便番号をorderに代入
      @order.name = @address.name #上記で代入された宛名をorderに代入
      @order.address = @address.shipping_address #上記で代入された住所をorderに代入
      else
       render 'new'
      end
    end
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
    params.require(:order).permit(:payment_method, :address, :postal_code, :name, :total_price,)
  end
end
