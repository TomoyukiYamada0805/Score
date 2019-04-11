class EvaluateMatch < ApplicationRecord
    has_many :match, primary_key: :match_id, foreign_key: :match_id
    has_one  :user, primary_key: :user_id, foreign_key: :uid
    has_many :likes
end
