require 'json'
require 'net/http'
require 'open-uri'

class Movie < ActiveRecord::Base
  attr_accessible :name, :imdb_id, :poster
  has_many :posts, foreign_key: :imdb_id, primary_key: :imdb_id ,dependent: :destroy
  
  before_validation  do
    if poster
      image = "app/assets/images/covers/#{self.imdb_id}.png"
      file = open(image, 'wb') do |file|
        file << open(poster).read
      end
      self.poster = "covers/#{imdb_id}.png"
    else
      self.poster = "covers/nocover.png"
    end
  end
  
  def self.fetch_from_imdb (imdbid)
    response = Net::HTTP.get_response('www.omdbapi.com', "/?i=#{imdbid}")
    js = JSON.parse(response.body)
    movie = Movie.new({:imdb_id => imdbid, :name => js['Title']})
    movie.actors = js['Actors']
    movie.countries = js['Country']
    movie.duration = js['Runtime']
    movie.genres = js['Genre']
    movie.score = js['imdbRating']
    movie.votes = js['imdbVotes'].to_s.delete!(',')
    movie.writers = js['Writer']
    movie.year = js['Year']
    # save poster to server
    if js['Poster'] != 'N/A'
      movie.poster = js['Poster']
    end
    return movie
  end
  
  def self.search(search)
    if search
      find(:all, :conditions => ['name LIKE ?', "%#{search}%"])
    else
      find(:all)
    end
  end
  
  def to_param
    imdb_id
  end
end
