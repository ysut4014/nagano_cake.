class Admin::OrdersController < ApplicationController
	before_action :authenticate_admin!

	def index
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
  @order.update(order_params)

  if @order.status == "製作中"  # Assuming 'status' is the correct attribute
    # Your logic here
  end

  redirect_to admin_order_path(@order)
end

private

def order_params
  params.require(:order).permit(:status)
end

  private
def order_params
  params.require(:order).permit(:status)
end


end