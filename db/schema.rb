# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120324185058) do

  create_table "top_shows", :force => true do |t|
    t.integer  "tv_show_id"
    t.integer  "position"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tv_episodes", :force => true do |t|
    t.integer  "tv_season_id"
    t.integer  "number"
    t.integer  "seriesnum"
    t.integer  "season_number"
    t.string   "name"
    t.text     "description"
    t.date     "airdate"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tv_images", :force => true do |t|
    t.integer  "tv_show_id"
    t.string   "file_name"
    t.string   "content_type"
    t.integer  "file_size"
    t.binary   "file_data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tv_seasons", :force => true do |t|
    t.integer  "tv_show_id"
    t.integer  "number"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tv_show_episodes", :force => true do |t|
    t.integer  "tv_show_id"
    t.integer  "tv_episode_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tv_shows", :force => true do |t|
    t.string   "name"
    t.string   "network"
    t.datetime "air_time"
    t.date     "premiered"
    t.text     "description"
    t.string   "icon_file_name"
    t.string   "icon_sha1"
    t.string   "icon_content_type", :limit => 40
    t.integer  "icon_file_size"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_episodes", :force => true do |t|
    t.integer  "user_id"
    t.integer  "tv_episode_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_shows", :force => true do |t|
    t.integer  "user_id"
    t.integer  "tv_show_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "handle"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "salt"
    t.string   "role"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "crypted_password"
    t.string   "persistence_token"
  end

end
