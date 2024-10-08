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

ActiveRecord::Schema[7.1].define(version: 2024_09_09_164709) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "bloom_colors", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "bloom_colors_plants", id: false, force: :cascade do |t|
    t.bigint "plant_id", null: false
    t.bigint "bloom_color_id", null: false
  end

  create_table "bloom_months", force: :cascade do |t|
    t.string "month_name"
    t.integer "month_number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["month_number"], name: "index_bloom_months_on_month_number"
  end

  create_table "bloom_months_plants", id: false, force: :cascade do |t|
    t.bigint "plant_id", null: false
    t.bigint "bloom_month_id", null: false
  end

  create_table "locations", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "organization_id", default: 1, null: false
    t.index ["organization_id"], name: "index_locations_on_organization_id"
  end

  create_table "notes", force: :cascade do |t|
    t.text "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "location_id"
    t.index ["location_id"], name: "index_notes_on_location_id"
  end

  create_table "organizations", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "plantings", id: false, force: :cascade do |t|
    t.bigint "location_id", null: false
    t.bigint "plant_id", null: false
    t.index ["location_id", "plant_id"], name: "index_plantings_on_location_id_and_plant_id"
    t.index ["plant_id", "location_id"], name: "index_plantings_on_plant_id_and_location_id"
  end

  create_table "plants", force: :cascade do |t|
    t.string "common_name", null: false
    t.string "other_common_names", default: [], array: true
    t.string "scientific_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "organization_id", default: 1, null: false
    t.index ["common_name"], name: "index_plants_on_common_name"
    t.index ["organization_id"], name: "index_plants_on_organization_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "organization_id", default: 1, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["organization_id"], name: "index_users_on_organization_id"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "locations", "organizations"
  add_foreign_key "notes", "locations"
  add_foreign_key "plantings", "locations"
  add_foreign_key "plantings", "plants"
  add_foreign_key "plants", "organizations"
  add_foreign_key "users", "organizations"
end
