class Player < ApplicationRecord
    belongs_to :match_player, primary_key: :player_id, foreign_key: :player_id
    belongs_to :evaluate_player, primary_key: :player_id, foreign_key: :player_id
    belongs_to :team, primary_key: :team_id, foreign_key: :team_id
end
