class Public::CartItemsController < ApplicationController
  include ActionText::Attachable
  def index
    @cart_items = current_customer.cart_items
  end

  def create
    cart_item = current_customer.cart_items.create(cart_item_params)

    if cart_item.save
      redirect_to cart_items_path, notice: 'Item added to cart successfully.'
    end
  end
  
  def destroy
    @cart_item = CartItem.find(params[:id])
    @cart_item.destroy
    redirect_to cart_items_path, notice: 'カートアイテムが削除されました'
  end
  
  private

  def cart_item_params
    params.require(:cart_item).permit(:item_id, :amount)
  end
end
