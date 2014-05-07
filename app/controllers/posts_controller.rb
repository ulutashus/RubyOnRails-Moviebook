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
end
