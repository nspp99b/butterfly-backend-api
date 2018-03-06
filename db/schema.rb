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

ActiveRecord::Schema.define(version: 20180306205312) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "connections", force: :cascade do |t|
    t.integer "follower_id"
    t.integer "followed_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["followed_id"], name: "index_connections_on_followed_id"
    t.index ["follower_id", "followed_id"], name: "index_connections_on_follower_id_and_followed_id", unique: true
    t.index ["follower_id"], name: "index_connections_on_follower_id"
  end

  create_table "flaps", force: :cascade do |t|
    t.text "content"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "active", default: true
    t.index ["user_id", "created_at"], name: "index_flaps_on_user_id_and_created_at"
  end

  create_table "relationships", force: :cascade do |t|
    t.integer "cause_id"
    t.integer "effect_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cause_id", "effect_id"], name: "index_relationships_on_cause_id_and_effect_id", unique: true
    t.index ["cause_id"], name: "index_relationships_on_cause_id"
    t.index ["effect_id"], name: "index_relationships_on_effect_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "image", default: "http://oakdome.com/k5/cartoons/cartoon-gallery/images/butterfly.png"
    t.index ["email"], name: "index_users_on_email", unique: true
  end

end
