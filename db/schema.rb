# File: schema.rb
# Purpouse: Have teh information off all the tables in the database
# License: GPL v3
# Group 10 Tecprog
# FGA - Universidade de Brasília - Campus Gama

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

ActiveRecord::Schema.define(version: 20150614152039) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "enterprises", force: :cascade do |t|
    t.string  "cnpj"
    t.string  "corporate_name"
    t.integer "sanctions_count", default: 0
    t.float   "payments_sum",    default: 0.0
  end

  create_table "payments", force: :cascade do |t|
    t.string  "identifier",     default: ""
    t.string  "process_number", default: ""
    t.float   "initial_value"
    t.date    "sign_date"
    t.date    "start_date"
    t.date    "end_date"
    t.integer "enterprise_id"
  end

  create_table "sanction_types", force: :cascade do |t|
    t.string "description"
    t.string "legal_foundation"
    t.string "foundation_description"
  end

  create_table "sanctions", force: :cascade do |t|
    t.date    "initial_date"
    t.date    "final_date"
    t.string  "process_number"
    t.integer "enterprise_id"
    t.integer "sanction_type_id"
    t.integer "state_id"
    t.string  "sanction_organ",   default: ""
  end

  create_table "states", force: :cascade do |t|
    t.integer "code"
    t.string  "name"
    t.string  "abbreviation"
  end

  create_table "users", force: :cascade do |t|
    t.string "login"
    t.string "password_digest"
    t.string "remember_token"
    t.string "type"
  end

end
