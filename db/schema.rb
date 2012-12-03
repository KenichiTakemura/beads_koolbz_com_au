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

ActiveRecord::Schema.define(:version => 20121120224900) do

  create_table "carousels", :force => true do |t|
    t.string   "name"
    t.boolean  "has_image",  :default => false
    t.string   "headline"
    t.string   "leadline"
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
  end

  create_table "categories", :force => true do |t|
    t.string   "key"
    t.string   "name"
    t.boolean  "special"
    t.string   "headline"
    t.string   "leadline"
    t.integer  "open_status"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "contacts", :force => true do |t|
    t.integer  "contacted_by_id"
    t.string   "contacted_by_type"
    t.integer  "contact_type"
    t.text     "body"
    t.string   "user_name"
    t.string   "email"
    t.string   "phone"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
  end

  create_table "flyers", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "provider"
    t.string   "uid"
    t.string   "flyer_name"
    t.string   "flyer_image"
    t.string   "flyer_url"
    t.datetime "agreed_on"
    t.string   "agree_token"
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  add_index "flyers", ["provider", "uid"], :name => "index_flyers_on_provider_and_uid"
  add_index "flyers", ["reset_password_token"], :name => "index_flyers_on_reset_password_token", :unique => true

  create_table "images", :force => true do |t|
    t.boolean  "is_deleted",                              :default => false
    t.string   "avatar_file_name"
    t.datetime "avatar_updated_at"
    t.integer  "avatar_file_size"
    t.string   "avatar_content_type"
    t.string   "medium_size"
    t.string   "thumb_size"
    t.string   "original_size"
    t.integer  "write_at"
    t.integer  "attached_by_id"
    t.string   "attached_by_type"
    t.integer  "attached_id"
    t.string   "attached_type"
    t.datetime "created_at",                                                 :null => false
    t.datetime "updated_at",                                                 :null => false
    t.text     "something",           :limit => 16777215
    t.string   "source_url"
    t.string   "link_to_url"
  end

  create_table "item_carts", :force => true do |t|
    t.integer  "item_id"
    t.integer  "item_checkout_id"
    t.integer  "order_count",      :default => 1
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
  end

  create_table "item_checkouts", :force => true do |t|
    t.integer  "ordered_by_id"
    t.string   "ordered_by_type"
    t.integer  "order_id"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "item_histories", :force => true do |t|
    t.integer  "category_id"
    t.integer  "order_id"
    t.integer  "status"
    t.integer  "order_count",           :default => 1
    t.integer  "delivered_count",       :default => 0
    t.string   "barcode"
    t.float    "price_ex_gst"
    t.float    "subtotal_price_ex_gst"
    t.integer  "ordered_on"
    t.integer  "dispatched_on"
    t.boolean  "has_image",             :default => false
    t.string   "extra"
    t.datetime "created_at",                               :null => false
    t.datetime "updated_at",                               :null => false
  end

  create_table "items", :force => true do |t|
    t.integer  "category_id"
    t.integer  "status"
    t.integer  "open_status"
    t.integer  "views",           :default => 0
    t.string   "barcode"
    t.float    "price_ex_gst"
    t.float    "gst"
    t.float    "price_inc_gst"
    t.datetime "barcode_ordered"
    t.integer  "write_at"
    t.boolean  "has_image",       :default => false
    t.string   "extra"
    t.boolean  "main",            :default => false
    t.datetime "created_at",                         :null => false
    t.datetime "updated_at",                         :null => false
  end

  create_table "order_infos", :force => true do |t|
    t.string   "user_name"
    t.string   "email"
    t.string   "phone"
    t.string   "address"
    t.text     "body"
    t.integer  "order_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "orders", :force => true do |t|
    t.integer  "ordered_by_id"
    t.string   "ordered_by_type"
    t.string   "ordered_id"
    t.integer  "ordered_on"
    t.float    "ordered_price_ex_gst"
    t.datetime "created_at",           :null => false
    t.datetime "updated_at",           :null => false
  end

  create_table "sold_items", :force => true do |t|
    t.integer  "sold_on"
    t.integer  "sold_at"
    t.integer  "sold_by"
    t.float    "price_ex_gst"
    t.integer  "sold_id"
    t.string   "sold_type"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

end
