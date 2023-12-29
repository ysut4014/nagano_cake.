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

	def total(items_total_price)

	end
	
def update
  @order = Order.find(params[:id])
@order_details = OrderDetail.where(order_id: @order)


if @order.update(status_params)
  if @order.status.include?("入金確認")
    # Make sure @order_details is loaded as a collection of OrderDetail instances
    @order.order_details.update_all(making_status: OrderDetail.making_statuses[:製作中])
  end
end

end
  def total_amount
    order.sum(:amount)
  end

private
def status_params
  params.require(:order).permit(:order_status)
end

end