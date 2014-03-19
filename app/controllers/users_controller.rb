require "rubygems"
require "json"
require 'net/http'

class UsersController < ApplicationController
  # GET /users
  # GET /users.json
  def index
    if session[:user_id]
      @user = User.find(session[:user_id])
      @posters = Array.new 
      @user.posts.each do |post| 
          response = Net::HTTP.get_response('www.omdbapi.com', "/?i=#{post.imdb_id}")
          js = JSON.parse(response.body)
          @posters.push( js["Poster"] )
      end
      render 'index'
    else
      redirect_to root_url
    end
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @user = User.find_by_name(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user }
    end
  end

  def new
    @user = User.new
  end

  # GET /users/1/edit
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
    
#    if params[:user][:password] == params[:user][:repassword]
#      @user = User.new(name: params[:user][:name], email: params[:user][:email],
#        password: params[:user][:password])
#      if @user.save
#        sign_in @user
#        redirect_to @user
#      else
#        render "new"
#      end
#    else
#        @user.errors.add(:password, "Paswords aren't same")
#        render "new"
#    end
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
  
  def app_signin
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
  
  def app_signup
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
  
  private

    def user_params
      params.require(:user).permit(:name, :email, :password)
    end
end
