class Public::OrdersController < ApplicationController
  # ...

  def thanks
  end

  def show
    @order = Order.find(params[:id])
  end

  def index
    @orders = Order.where(customer_id: current_customer.id).order(created_at: :desc).page(params[:page]).per(10)
  end

  def new
    @order = Order.new
    @addresses = current_customer.addresses
  end

def confirm
  @order = Order.new(order_params)
  @order.postal_code = current_customer.postal_code
  @order.address = current_customer.address
  @order.name = current_customer.first_name + current_customer.last_name

  # Assuming you have a method to retrieve cart items for the current customer
  @cart_items = current_customer.cart_items

  # Ensure @cart_items is not nil
  if @cart_items.nil? || @cart_items.empty?
    flash[:alert] = 'カートに商品がありません。'
    redirect_to root_path
    return
  end


  @total = 0
  @cart_items.each do |cart_item|
    @total += (cart_item.item.price_without_tax * 1.1).floor * cart_item.amount
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

    if destination == 0
      # 自身の住所を選択
      session[:order][:postal_code] = @customer.postal_code
      session[:order][:address] = @customer.address
      session[:order][:name] = @customer.last_name + @customer.first_name
    elsif destination == 1
      # 登録住所を選択
      address = ShippingAddress.find(params[:shipping_address_for_order])
      session[:order][:postal_code] = address.postal_code
      session[:order][:address] = address.address
      session[:order][:name] = address.name
    elsif destination == 2
      # 新しいお届け先を選択
      session[:new_address] = 2
      session[:order][:postal_code] = params[:postal_code]
      session[:order][:address] = params[:address]
      session[:order][:name] = params[:name]
    end

    if session[:order][:postal_code].presence && session[:order][:address].presence && session[:order][:name].presence
      redirect_to orders_thanks_path
    else
      redirect_to customers_orders_about_path
    end
  end

  def order_params
    params.require(:order).permit(:payment_method, :address_number, :address_id, :postal_code, :name)
  end
end
