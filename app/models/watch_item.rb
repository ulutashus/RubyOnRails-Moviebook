class WatchItem < ActiveRecord::Base
  attr_accessible :user_id, :movie_id, :sync
  belongs_to :user, class_name: "User"
  belongs_to :movie, class_name: "Movie"
end
