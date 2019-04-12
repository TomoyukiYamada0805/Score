class Team < ApplicationRecord
    belongs_to :match_info, primary_key: :team_id, foreign_key: :team_id
    has_many :match, primary_key: :team_id, foreign_key: :home_team_id
    has_many :match, primary_key: :team_id, foreign_key: :away_team_id
end
