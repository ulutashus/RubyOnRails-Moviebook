class PostsController < ApplicationController
  #like&unlike operations
  def show
    post = Post.find(params[:id])
    if post and current_user
      if params[:commit].include?('Like')
        post.like!(current_user.id)
      elsif params[:commit].include?('Unlike')
        post.unlike!(current_user.id)
      end
    end
    redirect_to :back
  end
  
  def app_post
    result = false
    begin
      if( params[:security_code] == "ulutashus|aeaytac" )
        id = User.find_by_name(params[:user_name]).id
        post = Post.new({:user_id => id, :title => params[:title], 
            :text => params[:text], :score => params[:score], 
            :imdb_id => params[:imdb_id]})
        post.save
        if (post)
          result = true
        end
      end
    rescue
    end
    
    respond_to do |format|
      format.all  { render :text => result }
    end
  end
end
