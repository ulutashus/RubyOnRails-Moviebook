class MoviesController < ApplicationController
  layout "user_layout"
  
  def index
    redirect_to root_path
  end
  
  def show
    @movie = Movie.find_by_imdb_id(params[:id])
    if(@movie)
      @mbookScore = 0
      @movie.posts.each do |p|
        @mbookScore += p.score
      end
      if @movie.posts.length > 0
        @mbookScore /= @movie.posts.length
      end
      render
    else
      redirect_to root_url
    end
  end
end
