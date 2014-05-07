class CreateWatchItems < ActiveRecord::Migration
  def change
    create_table :watch_items do |t|
      t.integer :user_id, :null => false
      t.integer :movie_id, :null => false
      t.timestamps
    end
    
    add_index :watch_items, :user_id
    add_index :watch_items, :movie_id
    add_index :watch_items, [:user_id, :movie_id], unique: true
  end
end
