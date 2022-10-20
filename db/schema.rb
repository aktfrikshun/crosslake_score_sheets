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

ActiveRecord::Schema[7.0].define(version: 2022_10_19_193821) do
  create_table "indicators", force: :cascade do |t|
    t.string "external_id"
    t.integer "score", default: 0
    t.integer "weight", default: 0
    t.integer "track_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["track_id"], name: "index_indicators_on_track_id"
  end

  create_table "reports", force: :cascade do |t|
    t.string "external_id"
    t.float "score", default: 0.0
    t.integer "scoring_sheet_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["scoring_sheet_id"], name: "index_reports_on_scoring_sheet_id"
  end

  create_table "scoring_sheets", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tracks", force: :cascade do |t|
    t.string "external_id"
    t.string "track_name"
    t.float "score", default: 0.0
    t.integer "report_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["report_id"], name: "index_tracks_on_report_id"
  end

end
