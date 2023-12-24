class Public::CartItemsController < ApplicationController
  include ActionText::Attachable

  def index
    @cart_items = current_customer.cart_items
    calculate_total_price
  end

def create
  @cart_item = current_customer.cart_items.find_or_initialize_by(item_id: cart_item_params[:item_id])

  # もし @cart_item.amount が現在 nil なら、0 で初期化する
  @cart_item.amount ||= 0

  # 初期化された @cart_item.amount に対して加算を行う
  @cart_item.amount += cart_item_params[:amount].to_i

  @cart_item.save
  redirect_to cart_items_path
end


 def update
  @cart_item = CartItem.find(params[:id])
  @cart_item.update(cart_item_params)
  redirect_to cart_items_path
 end
  
  def clear_cart
    current_customer.cart_items.destroy_all
    redirect_to cart_items_path, notice: 'カートを空にしました。'
  end
  
  def destroy
    @cart_item = CartItem.find(params[:id])
    @cart_item.destroy
    redirect_to cart_items_path, notice: 'カートから商品を削除しました'
  end
  
  private

  def cart_item_params
    params.require(:cart_item).permit(:item_id, :amount)
  end

  def calculate_total_price
    @cart_items = current_customer.cart_items
    @total_price = @cart_items.sum { |cart_item| cart_item.subtotal.to_i }
  end
end