class MatchInfo < ApplicationRecord
    belongs_to :match, primary_key: :match_id, foreign_key: :match_id
    has_many :team, primary_key: :team_id, foreign_key: :team_id
    has_many :evaluate_team, primary_key: :team_id, foreign_key: :team_id

end
