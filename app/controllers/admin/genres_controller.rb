class Admin::GenresController < ApplicationController
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
      render :new
    end
  end

  private

  def genre_params
    params.require(:genre).permit(:name)
  end
end