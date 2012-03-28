# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20111010135205) do

  create_table "pages", :force => true do |t|
    t.string   "title"
    t.text     "body"
    t.integer  "sidebar_id"
    t.string   "permalink"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "pages", ["permalink"], :name => "index_pages_on_permalink"

  create_table "people", :force => true do |t|
    t.string   "alias"
    t.string   "name"
    t.string   "email"
    t.string   "url"
    t.string   "position"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.string   "emaildisplay"
  end

  add_index "people", ["alias"], :name => "index_people_on_alias"
  add_index "people", ["name"], :name => "index_people_on_name"
  add_index "people", ["position"], :name => "index_people_on_position"

  create_table "people_publications", :id => false, :force => true do |t|
    t.integer "person_id"
    t.integer "publication_id"
  end

  add_index "people_publications", ["person_id", "publication_id"], :name => "index_people_publications_on_person_id_and_publication_id"
  add_index "people_publications", ["person_id"], :name => "index_people_publications_on_person_id"
  add_index "people_publications", ["publication_id"], :name => "index_people_publications_on_publication_id"

  create_table "posts", :force => true do |t|
    t.string   "title"
    t.text     "body"
    t.date     "published_on"
    t.integer  "author_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "posts", ["author_id"], :name => "index_posts_on_author_id"
  add_index "posts", ["published_on"], :name => "index_posts_on_published_on"

  create_table "publications", :force => true do |t|
    t.string   "kind"
    t.text     "authors"
    t.string   "title"
    t.integer  "venue_id"
    t.string   "venue_name"
    t.integer  "year"
    t.text     "abstract"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "pdf_file_name"
    t.string   "pdf_content_type"
    t.integer  "pdf_file_size"
    t.datetime "pdf_updated_at"
  end

  add_index "publications", ["kind"], :name => "index_publications_on_kind"
  add_index "publications", ["title"], :name => "index_publications_on_title"
  add_index "publications", ["venue_id"], :name => "index_publications_on_venue_id"
  add_index "publications", ["venue_name"], :name => "index_publications_on_venue_name"
  add_index "publications", ["year"], :name => "index_publications_on_year"

  create_table "venues", :force => true do |t|
    t.string   "name"
    t.integer  "publications_count", :default => 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "venues", ["name"], :name => "index_venues_on_name", :unique => true

end
