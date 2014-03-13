class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users  do |t|
      t.string :name, :unique => true, :limit => 25, :null => false
      t.string :pass, :limit => 25, :null => false
      t.string :email, :limit => 40, :null => false
      t.binary :app_data
    end
  end
end
