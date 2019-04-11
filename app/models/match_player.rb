class MatchPlayer < ApplicationRecord
    belongs_to :match, primary_key: :match_id, foreign_key: :match_id
    has_many :player, primary_key: :player_id, foreign_key: :player_id
end
