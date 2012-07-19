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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120719193515) do

  create_table "activities", :force => true do |t|
    t.date     "date"
    t.string   "message"
    t.string   "desc"
    t.integer  "student_id"
    t.integer  "repair_order_id"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "admin_users", :force => true do |t|
    t.text     "password_digest"
    t.text     "username"
    t.text     "fullname"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.text     "remember_token"
  end

  add_index "admin_users", ["username"], :name => "index_admin_users_on_username", :unique => true

  create_table "bills", :force => true do |t|
    t.string  "desc"
    t.float   "amount"
    t.boolean "labor"
    t.boolean "paid",            :default => false
    t.integer "repair_order_id"
    t.integer "student_id"
  end

  create_table "computer_ownerships", :force => true do |t|
    t.date     "startdate"
    t.date     "enddate"
    t.integer  "computer_id"
    t.integer  "student_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "computer_parts", :force => true do |t|
    t.boolean  "status"
    t.string   "description"
    t.integer  "computer_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.string   "name"
  end

  create_table "computer_templates", :force => true do |t|
    t.string   "parts"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "name"
  end

  create_table "computers", :force => true do |t|
    t.string   "idtag"
    t.string   "serial"
    t.string   "brand"
    t.string   "model"
    t.string   "location"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "computers", ["idtag"], :name => "index_computers_on_idtag", :unique => true
  add_index "computers", ["serial"], :name => "index_computers_on_serial", :unique => true

  create_table "repair_orders", :force => true do |t|
    t.date    "startdate"
    t.date    "enddate"
    t.integer "computer_id"
  end

  create_table "students", :force => true do |t|
    t.string   "firstname"
    t.string   "lastname"
    t.integer  "studentid"
    t.integer  "classof"
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
    t.integer  "access",     :default => 0
  end

  add_index "students", ["studentid"], :name => "index_students_on_studentid", :unique => true

end
