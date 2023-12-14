class Admin::ItemsController < ApplicationController
  before_action :get_genres, only: [:new, :edit, :show]

  def index
    @items = Item.page(params[:page]).per(10)
    
  end

  def new
    @item = Item.new
  end

  def edit
    @item = Item.find(params[:id])
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to admin_items_path, notice: 'Item was successfully created.'
    else
      render :new
    end
  end
  
  
  

  
  def show
    @item = Item.find(params[:id])
  end
  

  def update
    @item = Item.find(params[:id])

    if @item.update(item_params)
      redirect_to admin_item_path(@item), notice: 'Item was successfully updated.'
    else
      render :edit
    end
  end
  
  private

def item_params
  params.require(:item).permit(:image, :name, :introduction, :genre_id, :price, :is_sold_out)
end

  def get_genres
    @genres = Genre.all
  end
end
