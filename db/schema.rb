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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20170407184104) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "hstore"

  create_table "original_posts", force: :cascade do |t|
    t.string   "url"
    t.string   "account_name"
    t.string   "account_address"
    t.bigint   "external_id"
    t.integer  "post_type"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "sad_cats", force: :cascade do |t|
    t.integer  "point",              default: 0
    t.string   "creator"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.hstore   "image"
    t.integer  "original_tumblr_id"
    t.integer  "original_tweet_id"
    t.index ["original_tumblr_id"], name: "index_sad_cats_on_original_tumblr_id", using: :btree
    t.index ["original_tweet_id"], name: "index_sad_cats_on_original_tweet_id", using: :btree
  end

end
