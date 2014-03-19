class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name, :null => false
      t.string :email, :null => false
      t.string :password, :null => false
      t.binary :app_data

      t.timestamps
    end
  end
end
