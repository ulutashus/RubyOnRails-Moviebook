class IndexController < ApplicationController
  def index  
    if current_user
      @posts = Array.new 
      current_user.followed_users.each { |i|  
        @posts.concat(i.posts)
      }
      @posts.sort! { |x,y| y.created_at <=> x.created_at }
      render 'home', layout: "user_layout"
    else
      render 'index'
    end
  end
end
