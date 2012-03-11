class CreateTvEpisodes < ActiveRecord::Migration
  def change
    create_table :tv_episodes do |t|
      t.integer :tv_season_id
      t.integer :number
      t.integer :seriesnum
      t.string :name
      t.text :description
      t.date :airdate
      
      t.timestamps
    end
  end
end
