require 'json'
require 'net/http'
require 'open-uri'

class Movie < ActiveRecord::Base
  attr_accessible :name, :imdb_id, :poster
  has_many :posts, foreign_key: :imdb_id, primary_key: :imdb_id ,dependent: :destroy
  
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
    if js['Poster']
      image = "app/assets/images/covers/#{imdbid}.png"
      file = open(image, 'wb') do |file|
        file << open(js['Poster']).read
      end
      movie.poster = "covers/#{imdbid}.png"
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
