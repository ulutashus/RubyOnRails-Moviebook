class AddIndexToPosts < ActiveRecord::Migration
  def change
    add_index :posts, :imdb_id
    add_index :posts, [:user_id, :imdb_id], unique: true
  end
end
