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

ActiveRecord::Schema[7.0].define(version: 2024_04_23_201647) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "companies", force: :cascade do |t|
    t.string "title"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "status"
    t.integer "step_count"
    t.integer "completed_step_count"
    t.datetime "sync_completed_mail_sent_at"
    t.index ["user_id"], name: "index_companies_on_user_id"
  end

  create_table "onboarding_steps", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.string "video_info"
    t.datetime "completed_at"
    t.integer "step_order"
    t.boolean "locked"
    t.integer "step_input"
    t.bigint "company_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "completed", default: false
    t.string "related_ratio"
    t.boolean "skipped", default: false
    t.index ["company_id"], name: "index_onboarding_steps_on_company_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email"
    t.string "name"
    t.string "surname"
    t.integer "company_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "companies", "users"
  add_foreign_key "onboarding_steps", "companies"
end
