class Movie < ActiveRecord::Base
  attr_accessible :name, :imdb_id, :poster
  has_many :posts, foreign_key: :imdb_id, primary_key: :imdb_id ,dependent: :destroy
  
  def to_param
    imdb_id
  end
end
