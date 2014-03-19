class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :title
      t.text :text
      t.integer :score, limit: 10
      t.string :imdb_id
      t.references :user

      t.timestamps
    end
    
    add_index :posts, :user_id
  end
end
