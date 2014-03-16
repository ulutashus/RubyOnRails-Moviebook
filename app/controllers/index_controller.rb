class IndexController < ApplicationController
  def index  
    if session[:user_id]
      redirect_to users_url
    else
      render 'index'
    end
  end
end
