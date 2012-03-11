class CreateImages < ActiveRecord::Migration
  def change
    create_table :tv_images do |t|
      t.integer :tv_show_id
      t.string :file_name
      t.string :content_type
      t.integer :file_size
      t.binary :file_data

      t.timestamps
    end
  end
end
