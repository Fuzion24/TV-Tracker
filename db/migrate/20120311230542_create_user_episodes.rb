class CreateUserEpisodes < ActiveRecord::Migration
  def change
    create_table :user_episodes do |t|
      t.integer :user_id
      t.integer :tv_episode_id
      
      t.timestamps
    end
  end
end
