class Admin::OrdersController < ApplicationController
  before_action :authenticate_admin!

  def index
    @orders = Order.includes(order_details: :item).all
    @search = Order.ransack(params[:q])
    @orders = @search.result.page(params[:page]).per(10)
  end

  def show
    @order = Order.find(params[:id])
    @order_details = @order.order_details
  end

  def update
    order = Order.find(params[:id])
    order_details = order.order_details
    order.update(order_params)

    if order.status == "入金確認"
      order_details.each do |order_detail|
        order_detail.update(making_status: "製作待ち")
      end
    end
    redirect_to admin_order_path(order.id)
  end

  def total_amount
    order.sum(:amount)
  end

  private

	def order_params
		params.require(:order).permit(:status)
	end
end
