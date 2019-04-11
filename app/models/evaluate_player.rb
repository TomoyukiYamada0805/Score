class EvaluatePlayer < ApplicationRecord
    has_many :player, primary_key: :player_id, foreign_key: :player_id
    has_many :team, through: :player
end
