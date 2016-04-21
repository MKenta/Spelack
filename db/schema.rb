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

ActiveRecord::Schema.define(version: 20160421061228) do

  create_table "channels", force: :cascade do |t|
    t.string   "name",        limit: 190,             null: false
    t.integer  "status",      limit: 4,   default: 0, null: false
    t.string   "description", limit: 255
    t.integer  "author_id",   limit: 4
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "channels", ["name"], name: "index_channels_on_name", unique: true, using: :btree

  create_table "chats", force: :cascade do |t|
    t.text     "text",       limit: 65535
    t.integer  "user_id",    limit: 4
    t.integer  "channel_id", limit: 4
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "shared_files", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.integer  "channel_id", limit: 4
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  create_table "user_channels", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.integer  "channel_id", limit: 4
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  limit: 190, default: "", null: false
    t.string   "encrypted_password",     limit: 255, default: "", null: false
    t.string   "reset_password_token",   limit: 190
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,   default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.string   "nickname",               limit: 190, default: "", null: false
    t.string   "first_name",             limit: 255, default: "", null: false
    t.string   "middle_name",            limit: 255, default: ""
    t.string   "last_name",              limit: 255, default: "", null: false
    t.integer  "role",                   limit: 4
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["nickname"], name: "index_users_on_nickname", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
