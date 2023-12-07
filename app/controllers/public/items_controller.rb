class Public::ItemsController < ApplicationController
  before_action :get_genres, only: [:new, :edit]
  include ActionText::Attachable
  def show
    @item = Item.find(params[:id])
    @genres = Genre.all
    @genre = @item.genre
  end
 def about
 end
  def index
    @items = Item.paginate(page: params[:page], per_page: 12)
    @genres = Genre.all
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
    @genres = Genre.all 
  end  end
  private
  
  def item_params
    params.require(:item).permit(:name, :introduction, :genre_id, :price, :is_sold_out, :image)
  end
end
