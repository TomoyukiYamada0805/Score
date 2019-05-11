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

ActiveRecord::Schema.define(version: 2019_05_05_105132) do

  create_table "evaluate_coaches", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.integer "match_id"
    t.string "coach_name"
    t.float "evaluate_point"
    t.text "evaluate_comment"
    t.integer "del_flg"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "evaluate_matches", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.integer "match_id"
    t.integer "del_flg"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "evaluate_players", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.integer "match_id"
    t.integer "player_id"
    t.float "evaluate_point"
    t.text "evaluate_comment"
    t.integer "del_flg"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "evaluate_referees", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.integer "match_id"
    t.string "referee_name"
    t.float "evaluate_point"
    t.text "evaluate_comment"
    t.integer "del_flg"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "evaluate_teams", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.integer "match_id"
    t.integer "team_id"
    t.float "evaluate_point"
    t.text "evaluate_comment"
    t.integer "del_flg"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "likes", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci", force: :cascade do |t|
    t.bigint "post_user_id"
    t.integer "match_id"
    t.bigint "like_user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "match_infos", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci", force: :cascade do |t|
    t.integer "match_id", null: false
    t.integer "team_type", null: false, comment: "0:home, 1:away"
    t.integer "team_id", null: false
    t.string "first_point", null: false
    t.string "second_point", null: false
    t.integer "control_rate"
    t.integer "shoot_count"
    t.integer "frame_count"
    t.integer "mileage"
    t.integer "sprint_count"
    t.integer "pass_count"
    t.integer "pass_success_rate"
    t.integer "offside"
    t.integer "freekick_count"
    t.integer "cornerkick_count"
    t.integer "penalty_kick"
    t.integer "del_flg"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "match_players", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci", force: :cascade do |t|
    t.integer "match_id", null: false
    t.integer "player_id"
    t.integer "team_type", null: false, comment: "0:home, 1:away"
    t.integer "player_type", null: false, comment: "0: 選手, 1: 監督, 2: 審判"
    t.string "player_name", comment: "監督、審判の名前を入れる"
    t.integer "starting_flg", default: 0, comment: "スターティングメンバー:1"
    t.string "player_change"
    t.string "position"
    t.integer "sort_no"
    t.integer "del_flg"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "match_progresses", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci", force: :cascade do |t|
    t.integer "match_id", null: false
    t.integer "team_type", null: false, comment: "0:home, 1:away"
    t.integer "progress_type", null: false
    t.string "progress_time", null: false
    t.string "scorer"
    t.string "yellow_card"
    t.string "red_card"
    t.string "from_change_player"
    t.string "to_change_player"
    t.integer "del_flg"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "match_referees", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci", force: :cascade do |t|
    t.integer "match_id", null: false
    t.string "referee_name", null: false
    t.integer "referee_type", null: false
    t.integer "del_flg"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "matches", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci", force: :cascade do |t|
    t.integer "match_id", null: false
    t.integer "league_type", null: false
    t.integer "section", null: false
    t.integer "home_team_id"
    t.integer "away_team_id"
    t.string "match_date", null: false
    t.integer "del_flg"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "players", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci", force: :cascade do |t|
    t.integer "player_type", null: false, comment: "0: 選手, 1: 監督, 2: 審判"
    t.integer "player_id"
    t.integer "team_id"
    t.string "player_name"
    t.integer "profile_number"
    t.string "position"
    t.integer "del_flg"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "relationships", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci", force: :cascade do |t|
    t.integer "follower_id"
    t.integer "followed_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["followed_id"], name: "index_relationships_on_followed_id"
    t.index ["follower_id", "followed_id"], name: "index_relationships_on_follower_id_and_followed_id", unique: true
    t.index ["follower_id"], name: "index_relationships_on_follower_id"
  end

  create_table "teams", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci", force: :cascade do |t|
    t.integer "team_id"
    t.string "team_name"
    t.string "short_name"
    t.string "team_color"
    t.integer "del_flg"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci", force: :cascade do |t|
    t.string "user_name"
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "provider"
    t.string "uid"
    t.string "avatar"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
