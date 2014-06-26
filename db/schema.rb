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

ActiveRecord::Schema.define(version: 20140626222931) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "answers", force: true do |t|
    t.integer  "question_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "choice_index"
    t.integer  "exam_answer_id"
  end

  add_index "answers", ["question_id"], name: "index_answers_on_question_id", using: :btree
  add_index "answers", ["user_id"], name: "index_answers_on_user_id", using: :btree

  create_table "choices", force: true do |t|
    t.integer  "exam_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "content"
  end

  add_index "choices", ["exam_id"], name: "index_choices_on_exam_id", using: :btree

  create_table "exam_answers", force: true do |t|
    t.integer  "exam_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "status",     default: false
    t.integer  "score"
  end

  add_index "exam_answers", ["exam_id"], name: "index_exam_answers_on_exam_id", using: :btree
  add_index "exam_answers", ["user_id"], name: "index_exam_answers_on_user_id", using: :btree

  create_table "exams", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "special",    default: false
  end

  create_table "questions", force: true do |t|
    t.integer  "exam_id"
    t.string   "content"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "mask"
  end

  add_index "questions", ["exam_id"], name: "index_questions_on_exam_id", using: :btree

  create_table "task_statuses", force: true do |t|
    t.integer  "task_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "value"
  end

  add_index "task_statuses", ["task_id"], name: "index_task_statuses_on_task_id", using: :btree
  add_index "task_statuses", ["user_id"], name: "index_task_statuses_on_user_id", using: :btree

  create_table "tasks", force: true do |t|
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
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
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_type",              default: 0
    t.integer  "age"
    t.string   "name"
    t.string   "surname"
    t.string   "username"
    t.integer  "adviser_id"
    t.string   "user_code"
    t.integer  "status"
    t.string   "adviser_message"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
