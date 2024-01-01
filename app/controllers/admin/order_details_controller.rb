class Admins::OrderDetailsController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_order, only: [:update]

  def update
    @order_details = @order.order_details
    order_detail = OrderDetail.find(params[:id])
    order_detail.update(order_detail_params)

    case order_detail.making_status
    when "製作中"
      @order.update(status: "製作中")
    when "製作完了"
      if @order.order_details.all? { |detail| detail.making_status == "製作完了" }
        @order.update(status: "発送準備中")
      end
    end
    redirect_to admins_order_path(@order.id)
  end

  private

  def set_order
    # @order を正しく取得するためのコードを追加する
    # 例: @order = Order.find(params[:order_id])
  end

  def order_detail_params
    params.require(:order_detail).permit(:making_status)
  end
end
