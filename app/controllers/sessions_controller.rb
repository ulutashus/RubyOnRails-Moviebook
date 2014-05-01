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
  
  def app_new
    result = false
    if( params[:security_code] == "ulutashus|aeaytac" )
      user = User.authenticate(params[:name], params[:pass])
      if (user)
        result = true
      end
    end
    
    respond_to do |format|
      format.all  { render :text => result }
    end
  end
  
end