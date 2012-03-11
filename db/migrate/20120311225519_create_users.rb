class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :handle
      t.string :first_name
      t.string :last_name
      t.string :hashed_password
      t.string :salt
      t.string :role

      t.timestamps
    end
  end
end
