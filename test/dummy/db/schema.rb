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

ActiveRecord::Schema.define(version: 20160928142743) do

  create_table "articles", force: :cascade do |t|
  end

  create_table "rails_stages", force: :cascade do |t|
    t.string   "uuid",                        null: false
    t.string   "table",                       null: false
    t.string   "column",                      null: false
    t.integer  "row_id",                      null: false
    t.string   "predecessor",                 null: false
    t.text     "text_value",                  null: false
    t.string   "type",                        null: false
    t.string   "creator",     default: ""
    t.string   "authorizer",  default: ""
    t.boolean  "reversion",   default: false
    t.boolean  "applied",     default: false
    t.datetime "created_at"
    t.datetime "edited_at"
  end

  add_index "rails_stages", ["table", "column", "row_id"], name: "index_rails_stages_on_table_and_column_and_row_id"
  add_index "rails_stages", ["uuid"], name: "index_rails_stages_on_uuid"

end
