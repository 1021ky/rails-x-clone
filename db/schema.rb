# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2024_10_02_234905) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "tweets", force: :cascade do |t|
    t.string "content"
    t.bigint "x_user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["x_user_id"], name: "index_tweets_on_x_user_id"
  end

  create_table "x_users", force: :cascade do |t|
    t.string "email"
    t.string "sso_provider"
    t.string "sso_uid"
    t.string "name", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_x_users_on_email", unique: true
    t.index ["name"], name: "index_x_users_on_name", unique: true
    t.index ["sso_uid"], name: "index_x_users_on_sso_uid", unique: true
  end

  add_foreign_key "tweets", "x_users"
end
