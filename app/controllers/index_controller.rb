class IndexController < ApplicationController
  def index  
    if current_user
      @posts = Array.new 
      current_user.followed_users.each { |i|  
        @posts.concat(i.posts)
      }
      render 'home', layout: "user_layout"
    else
      render 'index'
    end
  end
end
