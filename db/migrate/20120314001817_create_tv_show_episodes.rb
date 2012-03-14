class CreateTvShowEpisodes < ActiveRecord::Migration
  def change
    create_table :tv_show_episodes do |t|
      t.integer :tv_show_id
      t.integer :tv_episode_id
      t.timestamps
    end
  end
end
