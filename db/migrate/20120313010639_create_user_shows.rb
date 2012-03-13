class CreateUserShows < ActiveRecord::Migration
  def change
    create_table :user_episodes do |t|
      t.integer :user_id
      t.integer :tv_show_id
      
      t.timestamps
    end
  end
end
