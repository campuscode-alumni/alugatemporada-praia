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

ActiveRecord::Schema.define(version: 20180314222108) do

  create_table "owners", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "owner_name"
    t.index ["email"], name: "index_owners_on_email", unique: true
    t.index ["reset_password_token"], name: "index_owners_on_reset_password_token", unique: true
  end

  create_table "properties", force: :cascade do |t|
    t.string "title"
    t.integer "maximum_guests"
    t.integer "minimum_rent"
    t.integer "maximum_rent"
    t.decimal "daily_rate"
    t.string "rent_purpose"
    t.string "property_location"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "property_type"
    t.text "description"
    t.integer "total_rooms"
    t.boolean "petfriendly"
    t.boolean "smoking_allowed"
    t.boolean "accessibility"
    t.integer "owner_id"
    t.index ["owner_id"], name: "index_properties_on_owner_id"
  end

  create_table "proposals", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "phone"
    t.string "rent_purpose"
    t.integer "maximum_guests"
    t.datetime "start_date"
    t.datetime "end_date"
    t.boolean "petfriendly"
    t.boolean "smoking_allowed"
    t.text "proposal_details"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "property_id"
    t.index ["property_id"], name: "index_proposals_on_property_id"
  end

end
