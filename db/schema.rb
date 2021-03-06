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

ActiveRecord::Schema.define(version: 2020_03_20_001058) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "event_instances", force: :cascade do |t|
    t.bigint "event_id"
    t.bigint "location_id"
    t.bigint "graphics_id"
    t.datetime "start_datetime"
    t.datetime "end_datetime"
    t.string "title"
    t.text "description"
    t.string "slug"
    t.text "link_url"
    t.string "flag"
    t.index ["event_id"], name: "index_event_instances_on_event_id"
    t.index ["flag"], name: "index_event_instances_on_flag"
    t.index ["graphics_id"], name: "index_event_instances_on_graphics_id"
    t.index ["location_id"], name: "index_event_instances_on_location_id"
    t.index ["slug"], name: "index_event_instances_on_slug"
  end

  create_table "events", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.string "slug"
    t.bigint "location_id"
    t.bigint "graphics_id"
    t.string "state", default: "draft"
    t.datetime "published_at"
    t.text "link_url"
    t.string "flag"
    t.boolean "church_service"
    t.index ["flag"], name: "index_events_on_flag"
    t.index ["graphics_id"], name: "index_events_on_graphics_id"
    t.index ["location_id"], name: "index_events_on_location_id"
    t.index ["slug"], name: "index_events_on_slug"
  end

  create_table "graphics", force: :cascade do |t|
    t.string "background_image_uid"
    t.string "background_image_thumbnail_uid"
    t.string "background_image_thumbnail_2x_uid"
    t.string "background_image_320_uid"
    t.string "background_image_640_uid"
    t.string "background_image_960_uid"
    t.string "background_image_1280_uid"
    t.string "background_image_1920_uid"
    t.string "background_image_2560_uid"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "group_event_links", id: false, force: :cascade do |t|
    t.integer "grouping_id", null: false
    t.integer "event_id", null: false
    t.index ["event_id", "grouping_id"], name: "index_group_event_links_on_event_id_and_grouping_id"
    t.index ["grouping_id", "event_id"], name: "index_group_event_links_on_grouping_id_and_event_id"
  end

  create_table "group_type_links", id: false, force: :cascade do |t|
    t.integer "grouping_id", null: false
    t.integer "grouping_type_id", null: false
    t.index ["grouping_id", "grouping_type_id"], name: "index_group_type_links_on_grouping_id_and_grouping_type_id"
    t.index ["grouping_type_id", "grouping_id"], name: "index_group_type_links_on_grouping_type_id_and_grouping_id"
  end

  create_table "grouping_types", force: :cascade do |t|
    t.string "title"
    t.string "slug"
    t.index ["slug"], name: "index_grouping_types_on_slug"
  end

  create_table "groupings", force: :cascade do |t|
    t.string "title", null: false
    t.text "description"
    t.string "group_type", null: false
    t.datetime "start_date"
    t.datetime "end_date"
    t.string "slug"
    t.string "state", default: "draft"
    t.datetime "published_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "graphics_id"
    t.index ["graphics_id"], name: "index_groupings_on_graphics_id"
    t.index ["group_type"], name: "index_groupings_on_group_type"
    t.index ["slug"], name: "index_groupings_on_slug"
  end

  create_table "livestreams", force: :cascade do |t|
    t.string "youtubeId"
    t.datetime "live_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "locations", force: :cascade do |t|
    t.string "name"
    t.string "address_line_1"
    t.string "address_line_2"
    t.string "city"
    t.string "code"
    t.string "url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "people", force: :cascade do |t|
    t.string "first_name", null: false
    t.string "last_name", null: false
    t.string "display_name"
    t.string "job_title"
    t.string "biography_short"
    t.text "biography"
    t.string "avatar_original_uid"
    t.string "avatar_150_uid"
    t.string "avatar_300_uid"
    t.string "avatar_600_uid"
    t.boolean "page"
    t.string "slug"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "location_id"
    t.index ["location_id"], name: "index_people_on_location_id"
    t.index ["slug"], name: "index_people_on_slug"
  end

  create_table "people_teams", force: :cascade do |t|
    t.bigint "person_id", null: false
    t.bigint "team_id", null: false
    t.jsonb "meta"
    t.index ["person_id"], name: "index_people_teams_on_person_id"
    t.index ["team_id"], name: "index_people_teams_on_team_id"
  end

  create_table "resource_grouping_joins", force: :cascade do |t|
    t.integer "resource_id"
    t.integer "grouping_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["grouping_id"], name: "index_resource_grouping_joins_on_grouping_id"
    t.index ["resource_id"], name: "index_resource_grouping_joins_on_resource_id"
  end

  create_table "resources", force: :cascade do |t|
    t.string "title", null: false
    t.string "state", default: "draft"
    t.string "resource_type", null: false
    t.string "external_reference"
    t.text "body"
    t.text "introduction"
    t.string "slug"
    t.datetime "published_at"
    t.datetime "display_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "people_id"
    t.bigint "graphics_id"
    t.bigint "uploads_id"
    t.jsonb "bible_reference_json"
    t.integer "parent_resource_id"
    t.index ["graphics_id"], name: "index_resources_on_graphics_id"
    t.index ["parent_resource_id"], name: "index_resources_on_parent_resource_id"
    t.index ["people_id"], name: "index_resources_on_people_id"
    t.index ["resource_type"], name: "index_resources_on_resource_type"
    t.index ["slug"], name: "index_resources_on_slug"
    t.index ["uploads_id"], name: "index_resources_on_uploads_id"
  end

  create_table "resources_meta", force: :cascade do |t|
    t.string "meta_key", null: false
    t.text "meta_value", null: false
    t.bigint "resources_id"
    t.index ["meta_key"], name: "index_resources_meta_on_meta_key"
    t.index ["resources_id"], name: "index_resources_meta_on_resources_id"
  end

  create_table "teams", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.bigint "teams_id"
    t.index ["teams_id"], name: "index_teams_on_teams_id"
  end

  create_table "uploads", force: :cascade do |t|
    t.string "file_uid", null: false
    t.string "filesize"
    t.jsonb "meta", default: "{}", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["meta"], name: "index_uploads_on_meta", using: :gin
  end

  create_table "users", force: :cascade do |t|
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
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "event_instances", "events"
  add_foreign_key "event_instances", "graphics", column: "graphics_id"
  add_foreign_key "event_instances", "locations"
  add_foreign_key "events", "graphics", column: "graphics_id"
  add_foreign_key "events", "locations"
  add_foreign_key "groupings", "graphics", column: "graphics_id"
  add_foreign_key "people", "locations"
  add_foreign_key "resources", "graphics", column: "graphics_id"
  add_foreign_key "resources", "people", column: "people_id"
  add_foreign_key "resources", "uploads", column: "uploads_id"
  add_foreign_key "resources_meta", "resources", column: "resources_id"
  add_foreign_key "teams", "teams", column: "teams_id"
end
