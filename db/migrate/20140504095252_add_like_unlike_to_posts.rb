class AddLikeUnlikeToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :like, :integer, :default => 0
    add_column :posts, :unlike, :integer, :default => 0
  end
end
