class Admin::ItemsController < ApplicationController
  before_action :get_genres, only: [:new, :edit]
  def index
    @items = Item.all
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

  private

  def item_params
    # your strong parameters definition here
  end
  def get_genres
    @genres = Genre.all
  end
end