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

ActiveRecord::Schema[7.0].define(version: 2023_05_05_233204) do
  create_table "to_do_items", force: :cascade do |t|
    t.integer "to_do_list_id", null: false
    t.boolean "completed", null: false
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["to_do_list_id"], name: "index_to_do_items_on_to_do_list_id"
  end

  create_table "to_do_list_invites", force: :cascade do |t|
    t.integer "to_do_list_id"
    t.integer "inviter_id", null: false
    t.string "invitee_email", null: false
    t.string "name"
    t.integer "giver_id"
    t.integer "recipient_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["giver_id"], name: "index_to_do_list_invites_on_giver_id"
    t.index ["inviter_id"], name: "index_to_do_list_invites_on_inviter_id"
    t.index ["recipient_id"], name: "index_to_do_list_invites_on_recipient_id"
    t.index ["to_do_list_id"], name: "index_to_do_list_invites_on_to_do_list_id"
  end

  create_table "to_do_lists", force: :cascade do |t|
    t.string "name"
    t.integer "giver_id", null: false
    t.integer "recipient_id", null: false
    t.boolean "active", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["giver_id"], name: "index_to_do_lists_on_giver_id"
    t.index ["recipient_id"], name: "index_to_do_lists_on_recipient_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", null: false
    t.string "password_digest", null: false
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "confirmed_at"
    t.string "unconfirmed_email"
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "to_do_items", "to_do_lists"
  add_foreign_key "to_do_list_invites", "to_do_lists"
  add_foreign_key "to_do_list_invites", "users", column: "giver_id"
  add_foreign_key "to_do_list_invites", "users", column: "inviter_id"
  add_foreign_key "to_do_list_invites", "users", column: "recipient_id"
  add_foreign_key "to_do_lists", "users", column: "giver_id"
  add_foreign_key "to_do_lists", "users", column: "recipient_id"
end
