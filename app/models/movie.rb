class Movie < ActiveRecord::Base
  attr_accessible :name, :imdb_id, :poster
  has_many :posts, foreign_key: :imdb_id, primary_key: :imdb_id ,dependent: :destroy
  
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
