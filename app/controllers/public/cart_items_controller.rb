class Public::CartItemsController < ApplicationController
  include ActionText::Attachable

  def index
    @cart_items = current_customer.cart_items
    calculate_total_price
  end

  def create
    @cart_item = CartItem.new(cart_item_params)
    @cart_item.customer_id = current_customer.id
    @cart_item.item_id = params[:item_id]
   if @cart_item.save
    flash[:notice] = "#{@cart_item.item.name}をカートに追加しました。"
    redirect_to customers_cart_items_path
   else
    flash[:alert] = "個数を選択してください"
    render "customers/items/show"
   end
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