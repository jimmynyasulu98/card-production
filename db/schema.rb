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

ActiveRecord::Schema[7.0].define(version: 2024_04_28_183018) do
  create_table "academic_years", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "cards", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "cover_id", null: false
    t.bigint "location_id", null: false
    t.date "date_joined"
    t.date "date_of_expiry"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cover_id"], name: "index_cards_on_cover_id"
    t.index ["location_id"], name: "index_cards_on_location_id"
  end

  create_table "covers", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "locations", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "code"
  end

  create_table "members", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "first_name", null: false
    t.string "last_name", null: false
    t.string "membership_number", null: false
    t.date "date_of_birth", null: false
    t.date "date_joined"
    t.bigint "cover_id", null: false
    t.bigint "location_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "image_data"
    t.boolean "card_printed", default: false
    t.index ["cover_id"], name: "index_members_on_cover_id"
    t.index ["location_id"], name: "index_members_on_location_id"
  end

  create_table "student_academic_years", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "member_id", null: false
    t.bigint "location_id", null: false
    t.bigint "academic_year_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["academic_year_id"], name: "index_student_academic_years_on_academic_year_id"
    t.index ["location_id"], name: "index_student_academic_years_on_location_id"
    t.index ["member_id"], name: "index_student_academic_years_on_member_id"
  end

  add_foreign_key "cards", "covers"
  add_foreign_key "cards", "locations"
  add_foreign_key "members", "covers"
  add_foreign_key "members", "locations"
  add_foreign_key "student_academic_years", "academic_years"
  add_foreign_key "student_academic_years", "locations"
  add_foreign_key "student_academic_years", "members"
end
