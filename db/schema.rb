# encoding: UTF-8
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

ActiveRecord::Schema.define(:version => 20140504110959) do

  create_table "movies", :force => true do |t|
    t.string   "imdb_id"
    t.string   "name",       :null => false
    t.string   "year"
    t.string   "poster"
    t.string   "score"
    t.integer  "votes"
    t.string   "genres"
    t.string   "writers"
    t.string   "actors"
    t.string   "countries"
    t.string   "duration"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "movies", ["imdb_id"], :name => "index_movies_on_imdb_id"

  create_table "post_feelings", :force => true do |t|
    t.boolean  "like"
    t.integer  "user_id",    :null => false
    t.integer  "post_id",    :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "post_feelings", ["post_id"], :name => "index_post_feelings_on_post_id"
  add_index "post_feelings", ["user_id"], :name => "index_post_feelings_on_user_id"

  create_table "posts", :force => true do |t|
    t.string   "title"
    t.text     "text"
    t.integer  "score",      :limit => 10
    t.string   "imdb_id"
    t.integer  "user_id"
    t.datetime "created_at",                              :null => false
    t.datetime "updated_at",                              :null => false
    t.integer  "like",                     :default => 0
    t.integer  "unlike",                   :default => 0
  end

  add_index "posts", ["imdb_id"], :name => "index_posts_on_imdb_id"
  add_index "posts", ["user_id", "imdb_id"], :name => "index_posts_on_user_id_and_imdb_id", :unique => true
  add_index "posts", ["user_id"], :name => "index_posts_on_user_id"

  create_table "relationships", :force => true do |t|
    t.integer  "follower_id"
    t.integer  "followed_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "relationships", ["followed_id"], :name => "index_relationships_on_followed_id"
  add_index "relationships", ["follower_id", "followed_id"], :name => "index_relationships_on_follower_id_and_followed_id", :unique => true
  add_index "relationships", ["follower_id"], :name => "index_relationships_on_follower_id"

  create_table "users", :force => true do |t|
    t.string   "name",           :null => false
    t.string   "email",          :null => false
    t.string   "password",       :null => false
    t.binary   "app_data"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
    t.string   "remember_token"
  end

end
