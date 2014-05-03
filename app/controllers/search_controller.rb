class SearchController < ApplicationController
  def index 
    @movies = Movie.search(params[:id])
    render :layout => 'user_layout'
  end
end
