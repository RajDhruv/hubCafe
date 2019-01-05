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

ActiveRecord::Schema.define(version: 20181231151026) do

  create_table "cafe_users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "cafe_id"
    t.integer  "user_id"
    t.integer  "profile_type",    default: 2
    t.integer  "lock_version",    default: 0
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.integer  "from_invitation"
  end

  create_table "cafes", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.string   "description",  limit: 500, default: ""
    t.string   "slug",         limit: 150, default: ""
    t.integer  "admin_id"
    t.integer  "cafe_type"
    t.integer  "lock_version",             default: 0
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
  end

  create_table "invitations", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "cafe_id"
    t.integer  "approver_id"
    t.integer  "requestor_id"
    t.integer  "accepted_status", default: 0
    t.integer  "lock_version",    default: 0
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.integer  "age"
    t.string   "email"
    t.string   "password",      limit: 120
    t.string   "sex",           limit: 50
    t.datetime "date_of_birth"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.string   "profile_def",               default: "", null: false
    t.string   "profile_img"
  end

end
