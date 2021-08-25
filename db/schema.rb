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

ActiveRecord::Schema.define(version: 2021_08_25_020133) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "content", force: :cascade do |t|
    t.string "title", null: false
    t.string "url", null: false
    t.string "sharing_url", null: false
    t.string "file_url"
    t.string "thumbnail_img_url"
    t.integer "scroll_position_x"
    t.integer "scroll_position_y"
    t.integer "max_scroll_position_x"
    t.integer "max_scroll_position_y"
    t.integer "video_playback_position"
    t.string "specified_text"
    t.string "specified_dom_id"
    t.string "specified_dom_class"
    t.string "specified_dom_tag"
    t.boolean "delete_flag", default: false, null: false
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.index ["id", "user_id"], name: "index_content_on_id_and_user_id"
    t.index ["user_id"], name: "index_content_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "provider", default: "email", null: false
    t.string "uid", default: "", null: false
    t.text "tokens"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["uid", "provider"], name: "index_users_on_uid_and_provider", unique: true
  end

  add_foreign_key "content", "users"
end
