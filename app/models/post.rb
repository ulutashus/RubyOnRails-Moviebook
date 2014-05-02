require 'json'
require 'net/http'

class Post < ActiveRecord::Base
  attr_accessible :imdb_id, :score, :text, :title, :user_id
  belongs_to :user, class_name: "User"
  belongs_to :imdb, class_name: "Movie", primary_key: "imdb_id"
  
  after_save do
    movie = Movie.find_by_imdb_id(imdb_id)
    if (!movie)
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
    end
    movie.save
  end
end
