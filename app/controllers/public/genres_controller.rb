class Public::GenresController < ApplicationController
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
  def show
    
    
  end  
  def update
    if @genre.update(genre_params)
      redirect_to admin_genres_path, notice: 'Genre was successfully updated.'
    else
      render :edit
    end
  end  
  def edit
  end  
end
