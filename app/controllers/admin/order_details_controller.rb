class Admins::OrderDetailsController < ApplicationController
  before_action :authenticate_admin!

def update
  @order_detail = OrderDetail.find(params[:id])
  @order_detail.update(order_detail_params)

  if @order_detail.making_status == "製作中"
    # 製作中の場合のロジック
    @order_detail.order.update(status: "製作中")
  end

  redirect_to admin_order_path(@order_detail.order.id)
end

private

def order_detail_params
  params.require(:order_detail).permit(:making_status)
end
end