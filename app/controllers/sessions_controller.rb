class SessionsController < ApplicationController
  def create
    user = User.authenticate(params[:session][:name], params[:session][:pass])
    if user
      sign_in user
      redirect_back_or user
    else
      redirect_to root_url, :notice => "Invalid email or password"
    end
  end

  def destroy
    sign_out
    redirect_to root_url, :notice => "Logged out!"
  end
end