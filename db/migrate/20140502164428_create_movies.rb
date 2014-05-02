class CreateMovies < ActiveRecord::Migration
  def change
    create_table :movies do |t|
      t.string :imdb_id

      t.string :name, :null => false
      t.string :year
      t.string :poster
      t.string :score
      t.integer :votes
      t.string :genres
      t.string :writers
      t.string :actors
      t.string :countries
      t.string :duration
      
      t.timestamps
    end
    
    add_index :movies, :imdb_id
  end
end
