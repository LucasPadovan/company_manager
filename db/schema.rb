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

ActiveRecord::Schema.define(:version => 20140729231912) do

  create_table "components", :force => true do |t|
    t.integer "custom_product_id"
    t.integer "product_id"
  end

  add_index "components", ["custom_product_id", "product_id"], :name => "index_components_on_custom_product_id_and_product_id"

  create_table "contacts", :force => true do |t|
    t.string   "name"
    t.string   "area"
    t.text     "details"
    t.integer  "firm_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "contacts", ["firm_id"], :name => "index_contacts_on_firm_id"

  create_table "firms", :force => true do |t|
    t.string   "nombre"
    t.string   "cuit"
    t.string   "afip_cond"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "interests", :force => true do |t|
    t.integer  "firm_id"
    t.integer  "product_id"
    t.string   "type"
    t.datetime "date"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "interests", ["firm_id", "product_id"], :name => "index_interests_on_firm_id_and_product_id"

  create_table "monthly_movements", :force => true do |t|
    t.string   "month"
    t.integer  "year"
    t.integer  "user_id"
    t.string   "status"
    t.float    "purchases_total"
    t.float    "purchases_iva_total"
    t.float    "purchases_otros_conc_total"
    t.float    "purchases_subtotal"
    t.float    "sales_total"
    t.float    "sales_iva_total"
    t.float    "sales_otros_conc_total"
    t.float    "sales_subtotal"
    t.datetime "created_at",                 :null => false
    t.datetime "updated_at",                 :null => false
  end

  create_table "prices", :force => true do |t|
    t.float    "purchase_price"
    t.float    "sale_price"
    t.integer  "user_id"
    t.datetime "date"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
    t.integer  "interest_id"
  end

  create_table "products", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.string   "rubro"
    t.integer  "user_id"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.string   "type"
    t.string   "unit"
    t.decimal  "initial_stock"
    t.decimal  "stock"
  end

  create_table "purchase_invoices", :force => true do |t|
    t.datetime "date"
    t.string   "invoice_type"
    t.string   "destination_type"
    t.float    "iva"
    t.float    "subtotal"
    t.float    "total"
    t.float    "retencion"
    t.float    "other_concepts"
    t.integer  "firm_id"
    t.integer  "monthly_movement_id"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
    t.string   "number"
  end

  add_index "purchase_invoices", ["firm_id"], :name => "index_purchase_invoices_on_firm_id"

  create_table "sale_invoices", :force => true do |t|
    t.datetime "date"
    t.string   "invoice_type"
    t.string   "number"
    t.float    "iva"
    t.float    "subtotal"
    t.float    "total"
    t.float    "retencion",           :default => 0.0
    t.float    "other_concepts",      :default => 0.0
    t.integer  "firm_id"
    t.integer  "monthly_movement_id"
    t.datetime "created_at",                           :null => false
    t.datetime "updated_at",                           :null => false
  end

  add_index "sale_invoices", ["firm_id"], :name => "index_sale_inovices_on_firm_id"
  add_index "sale_invoices", ["monthly_movement_id"], :name => "index_sale_inovices_on_monthly_movement_id"

  create_table "users", :force => true do |t|
    t.string   "name",                                   :null => false
    t.string   "lastname"
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.integer  "roles_mask",             :default => 0,  :null => false
    t.integer  "lock_version",           :default => 0,  :null => false
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["lastname"], :name => "index_users_on_lastname"
  add_index "users", ["name"], :name => "index_users_on_name"
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

  create_table "versions", :force => true do |t|
    t.string   "item_type",  :null => false
    t.integer  "item_id",    :null => false
    t.string   "event",      :null => false
    t.integer  "whodunnit"
    t.text     "object"
    t.datetime "created_at"
  end

  add_index "versions", ["item_type", "item_id"], :name => "index_versions_on_item_type_and_item_id"
  add_index "versions", ["whodunnit"], :name => "index_versions_on_whodunnit"

end
