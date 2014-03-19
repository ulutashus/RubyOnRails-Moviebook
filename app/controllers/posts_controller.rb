class PostsController < ApplicationController
  def app_post
    result = false
    if( params[:security_code] == "ulutashus|aeaytac" )
      post = Post.new({:user_id => params[:user_id], :title => params[:title], 
          :text => params[:text], :score => params[:score], 
          :imdb_id => params[:imdb_id]})
      post.save
      if (post)
        result = true
      end
    end
    
    respond_to do |format|
      format.all  { render :text => result }
    end
  end
end
