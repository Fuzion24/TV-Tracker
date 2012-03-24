class AuthlogicUser < ActiveRecord::Migration
  def up
    add_column :users, :crypted_password, :string
    add_column :users, :persistence_token, :string
    remove_column :users, :hashed_password 
  end

  def down
    remove_column :users, :crypted_password
    remove_column :users, :persistence_token
    add_column :users, :hashed_password
  end
end
