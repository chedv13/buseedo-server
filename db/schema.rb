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

ActiveRecord::Schema.define(version: 20180619102500) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_admin_comments", force: :cascade do |t|
    t.string "namespace"
    t.text "body"
    t.string "resource_type"
    t.bigint "resource_id"
    t.string "author_type"
    t.bigint "author_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id"
    t.index ["namespace"], name: "index_active_admin_comments_on_namespace"
    t.index ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id"
  end

  create_table "admin_users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_admin_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true
  end

  create_table "course_teachers", force: :cascade do |t|
    t.boolean "is_creator", default: false
    t.bigint "course_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["course_id"], name: "index_course_teachers_on_course_id"
    t.index ["user_id"], name: "index_course_teachers_on_user_id"
  end

  create_table "course_users", force: :cascade do |t|
    t.integer "current_number_of_points", default: 0, null: false
    t.boolean "is_completed", default: false, null: false
    t.boolean "is_current", default: false, null: false
    t.bigint "course_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "continued_at"
    t.index ["course_id"], name: "index_course_users_on_course_id"
    t.index ["user_id"], name: "index_course_users_on_user_id"
  end

  create_table "courses", force: :cascade do |t|
    t.boolean "is_published", default: false, null: false
    t.datetime "published_at"
    t.datetime "unpublished_at"
    t.integer "final_number_of_points", default: 0, null: false
    t.integer "rating", default: 0, null: false
    t.string "name", null: false
    t.text "description", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "cover_file_name"
    t.string "cover_content_type"
    t.integer "cover_file_size"
    t.datetime "cover_updated_at"
    t.text "full_description"
    t.string "background_image_file_name"
    t.string "background_image_content_type"
    t.integer "background_image_file_size"
    t.datetime "background_image_updated_at"
    t.bigint "course_level_id"
    t.jsonb "skills"
    t.index ["course_level_id"], name: "index_courses_on_course_level_id"
  end

  create_table "days", force: :cascade do |t|
    t.integer "number", null: false
    t.bigint "course_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["course_id"], name: "index_days_on_course_id"
  end

  create_table "decisions", force: :cascade do |t|
    t.integer "status", default: 0, null: false
    t.text "body", null: false
    t.bigint "user_task_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "teacher_id"
    t.text "feedback"
    t.index ["user_task_id"], name: "index_decisions_on_user_task_id"
  end

  create_table "levels", force: :cascade do |t|
    t.integer "number", null: false
    t.integer "required_number_of_points", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "skill_tasks", force: :cascade do |t|
    t.bigint "skill_id", null: false
    t.bigint "task_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["skill_id"], name: "index_skill_tasks_on_skill_id"
    t.index ["task_id"], name: "index_skill_tasks_on_task_id"
  end

  create_table "skills", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "skills_tasks", force: :cascade do |t|
    t.bigint "skill_id", null: false
    t.bigint "task_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["skill_id"], name: "index_skills_tasks_on_skill_id"
    t.index ["task_id"], name: "index_skills_tasks_on_task_id"
  end

  create_table "subscribers", force: :cascade do |t|
    t.string "email", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tasks", force: :cascade do |t|
    t.boolean "is_published", default: false, null: false
    t.integer "number_of_percentages", null: false
    t.integer "number_of_points", null: false
    t.integer "serial_number", null: false
    t.string "name", null: false
    t.text "body"
    t.bigint "day_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["day_id"], name: "index_tasks_on_day_id"
  end

  create_table "user_days", force: :cascade do |t|
    t.boolean "is_completed", default: false, null: false
    t.bigint "day_id"
    t.bigint "course_user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "started_at", null: false
    t.index ["course_user_id"], name: "index_user_days_on_course_user_id"
    t.index ["day_id"], name: "index_user_days_on_day_id"
  end

  create_table "user_task_intervals", force: :cascade do |t|
    t.datetime "started_at", null: false
    t.datetime "finished_at"
    t.bigint "user_task_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_task_id"], name: "index_user_task_intervals_on_user_task_id"
  end

  create_table "user_tasks", force: :cascade do |t|
    t.boolean "is_completed", default: false, null: false
    t.boolean "is_current", default: false, null: false
    t.bigint "user_day_id", null: false
    t.bigint "task_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["task_id"], name: "index_user_tasks_on_task_id"
    t.index ["user_day_id"], name: "index_user_tasks_on_user_day_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "provider", default: "email", null: false
    t.string "uid", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.boolean "gender"
    t.boolean "is_first_filling_passed", default: false, null: false
    t.date "birth_date"
    t.integer "current_number_of_points", default: 0, null: false
    t.integer "year_of_ending_of_educational_institution"
    t.string "academic_degree"
    t.string "area_of_studies", array: true
    t.string "country"
    t.string "current_job"
    t.string "dream_job"
    t.string "educational_institution"
    t.string "email"
    t.string "hobby"
    t.string "name"
    t.json "tokens"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "level_id", null: false
    t.string "avatar_file_name"
    t.string "avatar_content_type"
    t.integer "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.integer "category", default: 0, null: false
    t.text "description"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["level_id"], name: "index_users_on_level_id"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["uid", "provider"], name: "index_users_on_uid_and_provider", unique: true
  end

end
