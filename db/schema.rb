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

ActiveRecord::Schema.define(version: 2019_04_22_102934) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "element_suppliers", force: :cascade do |t|
    t.bigint "elements_id"
    t.bigint "suppliers_id"
    t.float "purchase_price_ht"
    t.float "purchase_tax"
    t.float "purchase_price_ttc"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["elements_id"], name: "index_element_suppliers_on_elements_id"
    t.index ["suppliers_id"], name: "index_element_suppliers_on_suppliers_id"
  end

  create_table "elements", force: :cascade do |t|
    t.string "title"
    t.string "description"
    t.string "category"
    t.string "unit"
    t.string "type_element"
    t.boolean "built"
    t.float "sales_price_ht"
    t.float "sales_tax"
    t.float "sales_price_ttc"
    t.float "purchase_price_ht"
    t.float "purchase_tax"
    t.float "purchase_price_ttc"
    t.string "legacy_ref"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "estimate_elements", force: :cascade do |t|
    t.bigint "element_id"
    t.bigint "estimate_id"
    t.float "quantity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["element_id"], name: "index_estimate_elements_on_element_id"
    t.index ["estimate_id"], name: "index_estimate_elements_on_estimate_id"
  end

  create_table "estimates", force: :cascade do |t|
    t.string "number"
    t.float "remise"
    t.string "client"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "join_elements", force: :cascade do |t|
    t.bigint "element_parent_id"
    t.bigint "element_child_id"
    t.float "quantity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["element_child_id"], name: "index_join_elements_on_element_child_id"
    t.index ["element_parent_id"], name: "index_join_elements_on_element_parent_id"
  end

  create_table "jwt_blacklist", force: :cascade do |t|
    t.string "jti", null: false
    t.index ["jti"], name: "index_jwt_blacklist_on_jti"
  end

  create_table "suppliers", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "authentication_token", limit: 30
    t.index ["authentication_token"], name: "index_users_on_authentication_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
