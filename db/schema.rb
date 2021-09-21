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

ActiveRecord::Schema.define(version: 2021_09_21_070449) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "countries", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "election_results", force: :cascade do |t|
    t.bigint "election_id", null: false
    t.bigint "party_id", null: false
    t.integer "votes"
    t.integer "seats"
    t.float "votes_percent_diff"
    t.integer "seats_diff"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "country_id", null: false
    t.index ["country_id"], name: "index_election_results_on_country_id"
    t.index ["election_id"], name: "index_election_results_on_election_id"
    t.index ["party_id", "election_id"], name: "index_election_results_on_party_id_and_election_id", unique: true
    t.index ["party_id"], name: "index_election_results_on_party_id"
  end

  create_table "elections", force: :cascade do |t|
    t.string "name"
    t.date "date"
    t.bigint "country_id", null: false
    t.boolean "has_seats"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["country_id"], name: "index_elections_on_country_id"
  end

  create_table "parties", force: :cascade do |t|
    t.string "name"
    t.bigint "country_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["country_id"], name: "index_parties_on_country_id"
  end

  add_foreign_key "election_results", "countries"
  add_foreign_key "election_results", "elections"
  add_foreign_key "election_results", "parties"
  add_foreign_key "elections", "countries"
  add_foreign_key "parties", "countries"
end
