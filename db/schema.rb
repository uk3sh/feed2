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

ActiveRecord::Schema.define(version: 20180926123251) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "accounts", force: :cascade do |t|
    t.string   "email"
    t.string   "subdomain"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "answers", force: :cascade do |t|
    t.text     "answer_text"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.integer  "question_id"
    t.integer  "submission_id"
    t.string   "contact"
    t.integer  "account_id"
    t.index ["account_id"], name: "index_answers_on_account_id", using: :btree
    t.index ["question_id"], name: "index_answers_on_question_id", using: :btree
    t.index ["submission_id"], name: "index_answers_on_submission_id", using: :btree
  end

  create_table "forms", force: :cascade do |t|
    t.text     "name"
    t.text     "url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "sender_ID"
    t.text     "message"
    t.string   "short_url"
    t.integer  "account_id"
    t.index ["account_id"], name: "index_forms_on_account_id", using: :btree
  end

  create_table "mc_questions", force: :cascade do |t|
    t.string   "question_text"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "questions", force: :cascade do |t|
    t.text     "question_text"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.integer  "form_id"
    t.string   "question_type"
    t.text     "option"
    t.integer  "account_id"
    t.index ["account_id"], name: "index_questions_on_account_id", using: :btree
    t.index ["form_id"], name: "index_questions_on_form_id", using: :btree
  end

  create_table "submissions", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "form_id"
    t.string   "contact"
    t.integer  "account_id"
    t.index ["account_id"], name: "index_submissions_on_account_id", using: :btree
    t.index ["form_id"], name: "index_submissions_on_form_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "subdomain"
    t.integer  "account_id"
    t.index ["account_id"], name: "index_users_on_account_id", using: :btree
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

  add_foreign_key "answers", "accounts"
  add_foreign_key "forms", "accounts"
  add_foreign_key "questions", "accounts"
  add_foreign_key "submissions", "accounts"
  add_foreign_key "users", "accounts"
end
