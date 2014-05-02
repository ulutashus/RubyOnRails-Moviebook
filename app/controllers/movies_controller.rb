class MoviesController < ApplicationController
  layout "user_layout"
  
  def index
    redirect_to root_path
  end
  
  def show
    @movie = Movie.find_by_imdb_id(params[:id])
    if(@movie)
      respond_to do |format|
        format.html
      end
    else
      redirect_to root_url
    end
  end
end
