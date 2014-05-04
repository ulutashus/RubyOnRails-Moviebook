class CreatePostFeelings < ActiveRecord::Migration
  def change
    create_table :post_feelings do |t|
      t.boolean :like
      t.integer :user_id, :null => false
      t.integer :post_id, :null => false
      t.timestamps
    end
    
    add_index :post_feelings, :user_id
    add_index :post_feelings, :post_id
  end
end
