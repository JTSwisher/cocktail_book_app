# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_04_21_173534) do

  create_table "cocktail_ingredients", force: :cascade do |t|
    t.integer "cocktail_id"
    t.integer "ingredient_id"
    t.string "quantity"
  end

  create_table "cocktails", force: :cascade do |t|
    t.string "name"
    t.string "instructions"
    t.integer "user_id"
    t.float "average_rating", default: 0.0
    t.integer "ratings_sum", default: 0
    t.integer "ratings_count", default: 0
  end

  create_table "favorites", force: :cascade do |t|
    t.integer "user_id"
    t.integer "cocktail_id"
    t.integer "rating"
    t.string "comments"
  end

  create_table "ingredients", force: :cascade do |t|
    t.string "name"
  end

  create_table "users", force: :cascade do |t|
    t.string "email"
    t.string "name"
    t.string "password_digest"
  end

end
