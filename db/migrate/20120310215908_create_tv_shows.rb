class CreateTvShows < ActiveRecord::Migration
  def change
    create_table :tv_shows do |t|
      t.string :name
      t.string :network
      t.datetime :air_time
      t.date :premiered
      t.text :description
      t.string   "icon_file_name",      :limit => 255
      t.string   "icon_content_type",   :limit => 40
      t.integer  "icon_file_size"
      t.timestamps
    end
  end
end
