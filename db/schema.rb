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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20111031040645) do

  create_table "coupons", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.string   "url"
    t.string   "price"
    t.string   "guid"
    t.datetime "published"
    t.string   "picture"
    t.string   "home"
    t.string   "home_url"
    t.integer  "location_id"
    t.integer  "stock"
    t.integer  "rank"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "delayed_jobs", :force => true do |t|
    t.integer  "priority",          :default => 0
    t.integer  "attempts",          :default => 0
    t.text     "handler"
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "worker_class_name"
    t.datetime "started_at"
    t.datetime "finished_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], :name => "delayed_jobs_priority"

  create_table "feed_entries", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.string   "url"
    t.string   "price"
    t.string   "fullprice"
    t.string   "guid"
    t.datetime "published"
    t.string   "picture"
    t.string   "home"
    t.string   "home_url"
    t.integer  "stock"
    t.integer  "rank"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "feedbacks", :force => true do |t|
    t.string   "subject"
    t.string   "email"
    t.text     "comment"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "locations", :force => true do |t|
    t.string "name"
  end

  create_table "pages", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "signups", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "city"
    t.string   "phone"
    t.text     "details"
  end

  create_table "users", :force => true do |t|
    t.string   "email"
    t.string   "search"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
