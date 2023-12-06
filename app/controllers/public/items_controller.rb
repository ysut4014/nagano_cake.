class Public::ItemsController < ApplicationController
  before_action :get_genres, only: [:new, :edit]
  include ActionText::Attachable
  def show
    @item = Item.find(params[:id])
    @genres = Genre.all  # Or replace with your logic to fetch genres
  end
 def about
 end
 
 
  def index
    @items = Item.page(params[:page]).per(10)
    @items = Item.all
  end
def create
  @item = Item.new(item_params)
  if @item.save
    redirect_to @item, notice: 'Item was successfully created.'
  else
    render :new
  end
end

  def show
  def show
    @item = Item.find(params[:id])
    @genres = Genre.all  # Or replace with your logic to fetch genres
  end  end
  private
  
  def item_params
    # permitメソッドの引数には適切なパラメーターを指定してください
    params.require(:item).permit(:name, :introduction, :genre_id, :price, :is_sold_out, :image)
  end
end
