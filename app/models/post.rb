require 'json'
require 'net/http'

class Post < ActiveRecord::Base
  attr_accessible :imdb_id, :score, :text, :title, :user_id, :like, :unlike
  belongs_to :user, class_name: :User
  belongs_to :movie, class_name: :Movie, primary_key: :imdb_id, foreign_key: :imdb_id
  has_many :feelings, class_name: :PostFeeling, dependent: :destroy,
                      primary_key: :id, foreign_key: :post_id
  
  after_save do
    movie = Movie.find_by_imdb_id(imdb_id)
    unless (movie)
      response = Net::HTTP.get_response('www.omdbapi.com', "/?i=#{imdb_id}")
      js = JSON.parse(response.body)
      movie = Movie.new({:imdb_id => imdb_id, :name => title})
      movie.actors = js['Actors']
      movie.countries = js['Country']
      movie.duration = js['Runtime']
      movie.genres = js['Genre']
      movie.poster = js['Poster']
      movie.score = js['imdbRating']
      movie.votes = js['imdbVotes']
      movie.writers = js['Writer']
      movie.year = js['Year']
      movie.save
    end
  end
  
  def like! (userid)
    new_feeling( userid, true )
  end
  
  def unlike! (userid)
    new_feeling( userid, false )
  end
end

private 
  def new_feeling ( userid, like )
    feeling = self.feelings.find_by_user_id(userid)
    if feeling 
      if (feeling.like ^ like)
        feeling.like = like
        self.like   += like ? 1 : -1
        self.unlike += like ? -1 : 1
      else
        feeling.delete
        self.like   -= like  ? 1 : 0
        self.unlike -= !like ? 1 : 0
      end
      feeling.save()
    else
      self.feelings << PostFeeling.new({
            :user_id => userid, 
            :post_id => self.id, 
            :like    => like })
      self.like   += like  ? 1 : 0
      self.unlike += !like ? 1 : 0
    end
    self.save()
  end
