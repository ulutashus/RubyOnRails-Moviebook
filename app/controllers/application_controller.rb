include SessionHelper

class ApplicationController < ActionController::Base
  protect_from_forgery
  force_ssl
  
  def app_signup
    result = false
    if( params[:security_code] == "ulutashus|aeaytac" )
        unless User.find_by_name(params[:name])
          @user = User.new
          @user.name = params[:name]
          @user.pass = params[:pass]
          @user.email = params[:email]
          @user.save()
          result = true
        end
    end
    respond result
  end
  
  def app_signin
    app_cmd() do
      true
    end
  end
  
  def app_post
    app_cmd() do
      post = Post.new({:user_id => user.id, :title => params[:title], 
          :text => params[:text], :score => params[:score], 
          :imdb_id => params[:imdb_id]})
      post.save
      post ? true : false
    end
  end
  
  def app_addwatch
    app_cmd() do |user|
      movie = Movie.find_by_imdb_id(params[:imdb_id])
      unless movie
        movie = Movie.fetch_from_imdb(params[:imdb_id])
        movie.save
      end
      
      if movie
        watch = WatchItem.new({:user_id=>user.id,:movie_id=>movie.id,:sync=>true})
        watch.save
      end
      watch ? true : false
    end
  end
  
  def app_sync
    app_cmd() do |user|
      result = ''
      items = user.watch_items.where(:sync => false)
      items.each() { |i|  
        i.sync = true
        i.save
        if result.length > 0
          result << ','
        end
        result << i.movie.imdb_id
      }
      result
    end
  end
  
private
  def app_cmd
    result = false
    begin
      if( params[:security_code] == "ulutashus|aeaytac" )
        user = User.authenticate(params[:name], params[:pass])
        if (user)
          result = yield(user)
        end
      end
    rescue
      result = false
    end
    respond result
  end
  
  def respond (result)
    respond_to do |format|
      format.all  { render :text => result }
    end
  end
  
end
