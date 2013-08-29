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

ActiveRecord::Schema.define(:version => 20130806154257) do

  create_table "extension_sites", :force => true do |t|
    t.integer  "site_id"
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "extension_sites", ["site_id"], :name => "index_extension_sites_on_site_id"

  create_table "feedback_groups", :force => true do |t|
    t.string   "name"
    t.integer  "site_id"
    t.text     "emails"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "feedback_groups", ["site_id"], :name => "index_groups_on_site_id"

  create_table "feedback_messages", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "subject"
    t.text     "message"
    t.integer  "site_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "feedback_messages", ["site_id"], :name => "index_feedbacks_on_site_id"

  create_table "feedback_messages_groups", :id => false, :force => true do |t|
    t.integer "message_id"
    t.integer "group_id"
  end

  add_index "feedback_messages_groups", ["group_id"], :name => "index_feedbacks_groups_on_group_id"
  add_index "feedback_messages_groups", ["message_id"], :name => "index_feedbacks_groups_on_feedback_id"

  create_table "groups_users", :id => false, :force => true do |t|
    t.integer "group_id"
    t.integer "user_id"
  end

  add_index "groups_users", ["group_id"], :name => "index_groups_users_on_group_id"
  add_index "groups_users", ["user_id"], :name => "index_groups_users_on_user_id"

  create_table "locales", :force => true do |t|
    t.string   "name"
    t.string   "flag"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "locales_sites", :id => false, :force => true do |t|
    t.integer "locale_id"
    t.integer "site_id"
  end

  add_index "locales_sites", ["locale_id"], :name => "index_locales_sites_on_locale_id"
  add_index "locales_sites", ["site_id"], :name => "index_locales_sites_on_site_id"

  create_table "menu_item_i18ns", :force => true do |t|
    t.integer  "menu_item_id"
    t.integer  "locale_id"
    t.string   "title"
    t.text     "description"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  add_index "menu_item_i18ns", ["locale_id"], :name => "index_menu_item_i18ns_on_locale_id"
  add_index "menu_item_i18ns", ["menu_item_id"], :name => "index_menu_item_i18ns_on_menu_item_id"

  create_table "menu_items", :force => true do |t|
    t.integer  "menu_id"
    t.boolean  "separator",   :default => false
    t.integer  "target_id"
    t.string   "target_type"
    t.string   "url"
    t.integer  "parent_id"
    t.integer  "position",    :default => 0
    t.boolean  "new_tab",     :default => false
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at",                     :null => false
    t.string   "html_class"
  end

  add_index "menu_items", ["menu_id"], :name => "index_menu_items_on_menu_id"
  add_index "menu_items", ["parent_id"], :name => "index_menu_items_on_parent_id"
  add_index "menu_items", ["target_id"], :name => "index_menu_items_on_target_id"

  create_table "menus", :force => true do |t|
    t.integer  "site_id"
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "menus", ["site_id"], :name => "index_menus_on_site_id"

  create_table "notifications", :force => true do |t|
    t.string   "title"
    t.text     "body"
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "old_menus", :force => true do |t|
    t.string   "title"
    t.string   "link"
    t.integer  "page_id"
    t.text     "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "old_menus", ["page_id"], :name => "index_old_menus_on_page_id"

  create_table "page_i18ns", :force => true do |t|
    t.integer  "page_id"
    t.integer  "locale_id"
    t.string   "title"
    t.text     "summary"
    t.text     "text"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "page_i18ns", ["locale_id"], :name => "index_page_i18ns_on_locale_id"
  add_index "page_i18ns", ["page_id"], :name => "index_page_i18ns_on_page_id"

  create_table "pages", :force => true do |t|
    t.datetime "date_begin_at"
    t.datetime "date_end_at"
    t.string   "status"
    t.integer  "author_id"
    t.string   "url"
    t.integer  "site_id"
    t.string   "source"
    t.string   "kind"
    t.string   "local"
    t.datetime "event_begin"
    t.datetime "event_end"
    t.string   "event_email"
    t.string   "subject"
    t.string   "align"
    t.string   "type"
    t.integer  "repository_id"
    t.string   "size"
    t.boolean  "publish",       :default => false
    t.boolean  "front",         :default => false
    t.integer  "position"
    t.integer  "view_count",    :default => 0
    t.datetime "created_at",                       :null => false
    t.datetime "updated_at",                       :null => false
  end

  add_index "pages", ["author_id"], :name => "index_pages_on_author_id"
  add_index "pages", ["repository_id"], :name => "index_pages_on_repository_id"
  add_index "pages", ["site_id"], :name => "index_pages_on_site_id"

  create_table "pages_repositories", :force => true do |t|
    t.integer "page_id"
    t.integer "repository_id"
  end

  add_index "pages_repositories", ["page_id"], :name => "index_pages_repositories_on_page_id"
  add_index "pages_repositories", ["repository_id"], :name => "index_pages_repositories_on_repository_id"

  create_table "repositories", :force => true do |t|
    t.integer  "site_id"
    t.string   "archive_file_name"
    t.string   "archive_content_type"
    t.integer  "archive_file_size"
    t.datetime "archive_updated_at"
    t.string   "description"
    t.datetime "created_at",           :null => false
    t.datetime "updated_at",           :null => false
  end

  add_index "repositories", ["site_id"], :name => "index_repositories_on_site_id"

  create_table "rights", :force => true do |t|
    t.string   "name"
    t.string   "controller"
    t.string   "action"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "rights_roles", :force => true do |t|
    t.integer  "right_id"
    t.integer  "role_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "rights_roles", ["right_id"], :name => "index_rights_roles_on_right_id"
  add_index "rights_roles", ["role_id"], :name => "index_rights_roles_on_role_id"

  create_table "roles", :force => true do |t|
    t.string   "name"
    t.string   "theme"
    t.integer  "site_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.text     "permissions"
  end

  add_index "roles", ["site_id"], :name => "index_roles_on_site_id"

  create_table "roles_users", :id => false, :force => true do |t|
    t.integer "role_id"
    t.integer "user_id"
  end

  add_index "roles_users", ["role_id"], :name => "index_roles_users_on_role_id"
  add_index "roles_users", ["user_id"], :name => "index_roles_users_on_user_id"

  create_table "settings", :force => true do |t|
    t.string   "name"
    t.string   "value"
    t.text     "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "site_components", :force => true do |t|
    t.integer  "site_id"
    t.string   "place_holder"
    t.text     "settings"
    t.string   "name"
    t.integer  "position"
    t.boolean  "publish",      :default => true
    t.integer  "visibility",   :default => 0
    t.string   "alias"
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at",                     :null => false
  end

  add_index "site_components", ["site_id"], :name => "index_site_components_on_site_id"

  create_table "sites", :force => true do |t|
    t.string   "name"
    t.string   "url"
    t.text     "description"
    t.integer  "body_width"
    t.text     "footer"
    t.string   "theme"
    t.boolean  "view_desc_pages",                 :default => false
    t.string   "per_page",                        :default => "5, 15, 30, 50, 100"
    t.integer  "per_page_default",                :default => 25
    t.boolean  "menu_dropdown",                   :default => false
    t.string   "title",             :limit => 50
    t.integer  "parent_id"
    t.integer  "view_count",                      :default => 0
    t.datetime "created_at",                                                        :null => false
    t.datetime "updated_at",                                                        :null => false
    t.integer  "top_banner_id"
    t.integer  "top_banner_width"
    t.integer  "top_banner_height"
    t.string   "domain"
  end

  add_index "sites", ["parent_id"], :name => "index_sites_on_parent_id"
  add_index "sites", ["top_banner_id"], :name => "index_sites_on_top_banner_id"

  create_table "sites_menus", :force => true do |t|
    t.integer  "site_id"
    t.integer  "menu_id"
    t.integer  "parent_id",  :default => 0
    t.string   "category"
    t.integer  "position"
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

  add_index "sites_menus", ["menu_id"], :name => "index_sites_menus_on_menu_id"
  add_index "sites_menus", ["site_id"], :name => "index_sites_menus_on_site_id"

  create_table "sites_pages", :force => true do |t|
    t.integer  "site_id"
    t.integer  "page_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "sites_pages", ["page_id"], :name => "index_sites_pages_on_page_id"
  add_index "sites_pages", ["site_id"], :name => "index_sites_pages_on_site_id"

  create_table "sites_styles", :force => true do |t|
    t.integer  "site_id"
    t.integer  "style_id"
    t.boolean  "publish",    :default => true
    t.datetime "created_at",                   :null => false
    t.datetime "updated_at",                   :null => false
  end

  add_index "sites_styles", ["site_id"], :name => "index_sites_styles_on_site_id"
  add_index "sites_styles", ["style_id"], :name => "index_sites_styles_on_style_id"

  create_table "styles", :force => true do |t|
    t.string   "name"
    t.text     "css"
    t.boolean  "publish",    :default => true
    t.integer  "owner_id"
    t.integer  "position",   :default => 0
    t.datetime "created_at",                   :null => false
    t.datetime "updated_at",                   :null => false
  end

  add_index "styles", ["owner_id"], :name => "index_styles_on_owner_id"

  create_table "taggings", :force => true do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "context",       :limit => 128
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id"], :name => "index_taggings_on_tag_id"
  add_index "taggings", ["taggable_id", "taggable_type", "context"], :name => "index_taggings_on_taggable_id_and_taggable_type_and_context"

  create_table "tags", :force => true do |t|
    t.string "name"
  end

  create_table "users", :force => true do |t|
    t.string   "login"
    t.string   "email"
    t.string   "crypted_password"
    t.string   "password_salt"
    t.string   "persistence_token"
    t.string   "single_access_token"
    t.string   "perishable_token"
    t.integer  "login_count",          :default => 0
    t.integer  "failed_login_count",   :default => 0
    t.datetime "last_request_at"
    t.datetime "current_login_at"
    t.datetime "last_login_at"
    t.string   "current_login_ip"
    t.string   "last_login_ip"
    t.string   "theme"
    t.boolean  "status",               :default => false
    t.boolean  "is_admin",             :default => false
    t.string   "first_name"
    t.string   "last_name"
    t.string   "phone"
    t.string   "mobile"
    t.string   "register"
    t.integer  "locale_id"
    t.datetime "created_at",                              :null => false
    t.datetime "updated_at",                              :null => false
    t.string   "unread_notifications"
  end

  add_index "users", ["locale_id"], :name => "index_users_on_locale_id"

  create_table "views", :force => true do |t|
    t.integer  "site_id"
    t.integer  "viewable_id"
    t.string   "viewable_type"
    t.integer  "user_id"
    t.string   "request_path"
    t.string   "user_agent"
    t.string   "session_hash"
    t.string   "ip_address"
    t.string   "referer"
    t.string   "query_string"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "views", ["site_id"], :name => "index_views_on_site_id"
  add_index "views", ["user_id"], :name => "index_views_on_user_id"

end
