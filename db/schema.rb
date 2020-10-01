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

ActiveRecord::Schema.define(version: 2020_09_30_234707) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "campuses", force: :cascade do |t|
    t.string "name", null: false
    t.string "city", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "courses", force: :cascade do |t|
    t.string "name", null: false
    t.string "kind", null: false
    t.string "level", null: false
    t.string "shift", null: false
    t.bigint "university_id"
    t.bigint "campus_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["campus_id"], name: "index_courses_on_campus_id"
    t.index ["university_id"], name: "index_courses_on_university_id"
  end

  create_table "universities", force: :cascade do |t|
    t.string "name", null: false
    t.decimal "score", precision: 5, scale: 2, default: "0.0"
    t.string "logo_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "courses", "campuses"
  add_foreign_key "courses", "universities"
end
