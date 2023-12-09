class Admin::GenresController < ApplicationController
  before_action :set_genre, only: [:edit, :update]
  def new
    
  end
  def index
    @genres = Genre.all
    @genre = Genre.new
  end
  def create
    @genre = Genre.new(genre_params)

    if @genre.save
      redirect_to admin_genres_path, notice: 'ジャンルが作成されました'
    else
      render :edit
    end
  end
  def update
    if @genre.update(genre_params)
      redirect_to admin_genres_path, notice: 'Genre was successfully updated.'
    else
      render :edit
    end
  end  
  
  def show
    @item = Item.find(params[:id])
  end
  
  def edit
  end  

  private
  
  def set_genre
    @genre = Genre.find(params[:id])
  end
  def genre_params
    params.require(:genre).permit(:name)
  end
end