class CreateTvSeasons < ActiveRecord::Migration
  def change
    create_table :tv_seasons do |t|
      t.integer :number
      t.text :description

      t.timestamps
    end
  end
end
