class Public::CartItemsController < ApplicationController
  include ActionText::Attachable

  def index
    @cart_items = current_customer.cart_items
    calculate_total_price
  end

def create
  @cart_item = current_customer.cart_items.build(cart_item_params)
  @cart_items = current_customer.cart_items.all
  @cart_items.each do |cart_item|
    if cart_item.item_id == @cart_item.item_id
      new_amount = cart_item.amount + @cart_item.amount
      cart_item.update_attribute(:amount, new_amount)
      @cart_item.delete
    end 
  end
  @cart_item.save
  redirect_to :cart_items
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
    @total_price = @cart_items.sum { |cart_item| cart_item.subtotal.to_i }
  end
end