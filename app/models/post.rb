class Post < ActiveRecord::Base
  attr_accessible :imdb_id, :score, :text, :title, :user_id
  belongs_to :user
end
