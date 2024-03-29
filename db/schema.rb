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

ActiveRecord::Schema[7.0].define(version: 2023_06_06_084925) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "chat_group_users", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "chat_group_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["chat_group_id"], name: "index_chat_group_users_on_chat_group_id"
    t.index ["user_id"], name: "index_chat_group_users_on_user_id"
  end

  create_table "chat_groups", force: :cascade do |t|
    t.string "image"
    t.string "group_name", null: false
    t.text "group_description"
    t.integer "owner_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "organization_id", null: false
    t.index ["organization_id"], name: "index_chat_groups_on_organization_id"
  end

  create_table "choices", force: :cascade do |t|
    t.string "body", null: false
    t.integer "correct_answer", default: 0, null: false
    t.bigint "question_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["question_id"], name: "index_choices_on_question_id"
  end

  create_table "comments", force: :cascade do |t|
    t.text "body", null: false
    t.bigint "user_id", null: false
    t.bigint "post_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["post_id"], name: "index_comments_on_post_id"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "likes", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "post_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["post_id"], name: "index_likes_on_post_id"
    t.index ["user_id", "post_id"], name: "index_likes_on_user_id_and_post_id", unique: true
    t.index ["user_id"], name: "index_likes_on_user_id"
  end

  create_table "messages", force: :cascade do |t|
    t.text "body", null: false
    t.bigint "user_id", null: false
    t.bigint "chat_group_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["chat_group_id"], name: "index_messages_on_chat_group_id"
    t.index ["user_id"], name: "index_messages_on_user_id"
  end

  create_table "meta_tags_lists", force: :cascade do |t|
    t.string "name"
    t.string "identifier"
    t.string "meta_taggable_type"
    t.bigint "meta_taggable_id"
    t.string "meta_title"
    t.text "meta_description"
    t.text "meta_keywords"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["meta_taggable_type", "meta_taggable_id"], name: "index_meta_tags_lists_on_meta_taggable"
  end

  create_table "organizations", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "posts", force: :cascade do |t|
    t.string "image"
    t.string "url"
    t.string "title", null: false
    t.text "body"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "organization_id", null: false
    t.index ["organization_id"], name: "index_posts_on_organization_id"
    t.index ["user_id"], name: "index_posts_on_user_id"
  end

  create_table "questions", force: :cascade do |t|
    t.string "title"
    t.string "image"
    t.string "url"
    t.text "sentence", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "organization_id", null: false
    t.text "hint"
    t.index ["organization_id"], name: "index_questions_on_organization_id"
    t.index ["user_id"], name: "index_questions_on_user_id"
  end

  create_table "taggings", force: :cascade do |t|
    t.bigint "tag_id", null: false
    t.bigint "post_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["post_id"], name: "index_taggings_on_post_id"
    t.index ["tag_id", "post_id"], name: "index_taggings_on_tag_id_and_post_id", unique: true
    t.index ["tag_id"], name: "index_taggings_on_tag_id"
  end

  create_table "tags", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_tags_on_name", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.string "name", limit: 255, null: false
    t.string "email", null: false
    t.string "avatar"
    t.integer "role", default: 0, null: false
    t.string "crypted_password"
    t.string "salt"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "chat_group_users", "chat_groups"
  add_foreign_key "chat_group_users", "users"
  add_foreign_key "chat_groups", "organizations"
  add_foreign_key "choices", "questions"
  add_foreign_key "comments", "posts"
  add_foreign_key "comments", "users"
  add_foreign_key "likes", "posts"
  add_foreign_key "likes", "users"
  add_foreign_key "messages", "chat_groups"
  add_foreign_key "messages", "users"
  add_foreign_key "posts", "organizations"
  add_foreign_key "posts", "users"
  add_foreign_key "questions", "organizations"
  add_foreign_key "questions", "users"
  add_foreign_key "taggings", "posts"
  add_foreign_key "taggings", "tags"
end
