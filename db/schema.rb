# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20151202195215) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "companies", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.datetime "last_scraped_time"
    t.string   "type"
    t.string   "primary_api_url"
    t.string   "secondary_api_url"
    t.string   "authentication_url"
    t.string   "primary_token"
    t.string   "secondary_token"
  end

  create_table "job_exchanges", force: :cascade do |t|
    t.string   "name"
    t.datetime "last_scraped_time"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.string   "type"
    t.string   "primary_api_url"
    t.string   "secondary_api_url"
    t.string   "authentication_url"
    t.string   "primary_token"
    t.string   "secondary_token"
  end

  create_table "job_postings", force: :cascade do |t|
    t.text     "content"
    t.integer  "salary_range_low"
    t.integer  "salary_range_high"
    t.integer  "years_experience"
    t.integer  "company_id"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.integer  "job_exchange_id"
    t.date     "job_posted_date"
    t.date     "last_active_date"
    t.string   "external_unique_identifier"
    t.string   "title"
    t.string   "company_name"
    t.string   "address"
    t.string   "latitude"
    t.string   "longitude"
    t.string   "source"
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
