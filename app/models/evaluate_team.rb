class EvaluateTeam < ApplicationRecord
    belongs_to :match_info, primary_key: :team_id, foreign_key: :team_id
end
