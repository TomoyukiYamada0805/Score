class EvaluateMatch < ApplicationRecord
    has_many :match, primary_key: :match_id, foreign_key: :match_id
    has_many :home_team, class_name: "Team", through: :match
    has_many :away_team, class_name: "Team", through: :match
    has_one  :user, primary_key: :user_id, foreign_key: :uid
    has_many :likes
end
