class CreateTopShows < ActiveRecord::Migration
  def change
    create_table :top_shows do |t|
      t.integer :tv_show_id
      t.integer :position
      t.timestamps
    end
  end
end
