require "rubygems"

class UsersController < ApplicationController
  layout "user_layout"
  
  # GET /users
  def index
    redirect_to root_url
  end

  # GET /users/id
  def show
    @user = User.find_by_name(params[:id])
    if(@user)
      respond_to do |format|
        format.html # show.html.erb
        format.json { render json: @user }
      end
    else
      redirect_to root_url
    end
  end

  def new
    @user = User.new
  end

  def app_new
    result = false
    if( params[:security_code] == "ulutashus|aeaytac" )
        if (User.find_by_name(params[:name]) == nil )
          @user = User.new
          @user.name = params[:name]
          @user.pass = params[:pass]
          @user.email = params[:email]
          @user.save()
          result = true
        end
    end
    
    respond_to do |format|
      format.all  { render :text => result }
    end
  end
  
  # GET /users/id/edit
  def edit
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      sign_in @user
      redirect_to @user
    else
      render 'new'
    end
  end

  # PUT /users/1
  # PUT /users/1.json
  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :no_content }
    end
  end
  
  def follow
    user = User.find(params[:id])
    current_user.follow!(user)
    redirect_to user
  end
  
  def unfollow
    user = User.find(params[:id])
    current_user.unfollow!(user)
    redirect_to user
  end
  
  private
    def user_params
      params.require(:user).permit(:name, :email, :password)
    end
end
