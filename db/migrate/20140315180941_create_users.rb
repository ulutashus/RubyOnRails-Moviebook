class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :password
      t.string :password_hash
      t.string :password_salt
      t.binary :app_data

      t.timestamps
    end
  end
end
