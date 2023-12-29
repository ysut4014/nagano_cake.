class Public::OrdersController < ApplicationController
  include Public::OrdersHelper
  before_action :authenticate_customer!
  before_action :cart_check, only: [:new, :confirm, :create]

  def cart_check
    unless CartItem.find_by(customer_id: current_customer.id)
      flash[:danger] = "カートに商品がない状態です"
      redirect_to root_url
    end
  end

  def new
    @order = Order.new
    @addresses = current_customer.addresses
  end

  def confirm
    @order = Order.new
    @cart_items = CartItem.where(customer_id: current_customer.id)
    customer = current_customer
    address_option = params[:order][:address_option].to_i

    @order.payment_method = params[:order][:payment_method].to_i
    @order.temporary_information_input(customer.id)

    if address_option == 0
      @order.order_in_address_display(customer.postal_code, customer.address, customer.full_name)
    elsif address_option == 1
      shipping = Address.find(params[:order][:registration_address])
      @order.order_in_address_display(shipping.postal_code, shipping.address, shipping.name)
    elsif address_option == 2
      @order.order_in_address_display(params[:order][:postal_code], params[:order][:address], params[:order][:name])
    else
    end
    unless @order.valid?
      flash[:danger] = "お届け先の内容に不備があります<br>・#{@order.errors.full_messages.join('<br>・')}"
      p @order.errors.full_messages
      redirect_back(fallback_location: root_path)
    end
    # render plain: @order.inspect
  end

def create
  @order = Order.new(order_params)
  @order.customer_id = current_customer.id
  @order.shipping_fee = 800

  if @order.save
    @cart_items = CartItem.where(customer_id: current_customer.id)
    @cart_items.each do |cart_item|
      order_detail = OrderDetail.new
        order_detail = OrderDetail.new
        order_detail.item_id = cart_item.item_id
        order_detail.order_id = @order.id
        order_detail.amount = cart_item.amount
        order_detail.price = change_price(cart_item.item.price)
        order_detail.making_status = 0
      if order_detail.save
        @cart_items.destroy_all
      end
    end
    redirect_to orders_thanks_path
  else
    # エラー時の処理
  end
end

  def thanks
  end

  def show
    @order = Order.find(params[:id])
  end

  def index
    @orders = Order.where(customer_id: current_customer.id).order(created_at: :desc)
  end
  
  def destroy_all
    Order.destroy_all
    redirect_to orders_path, notice: '全ての注文を削除しました。'
  end

  private

  def order_params
    params.require(:order).permit(:postal_code, :address, :sname, :total_price, :payment_method, :name)
  end

end