class CreateTvShows < ActiveRecord::Migration
  def change
    create_table :tv_shows do |t|
      t.string :name
      t.string :network
      t.datetime :air_time
      t.date :premiered
      t.text :description

      t.timestamps
    end
  end
end
