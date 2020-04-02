class MatchInfo < ApplicationRecord
    belongs_to :match, primary_key: :match_id, foreign_key: :match_id
    has_many :team, primary_key: :team_id, foreign_key: :team_id
    has_many :evaluate_team, primary_key: :team_id, foreign_key: :team_id

    scope :get_match_info, -> (current_user, match_id){select('*').where(match_id: match_id).left_outer_joins(:team).joins("LEFT OUTER JOIN `evaluate_teams` ON `evaluate_teams`.`team_id` = `match_infos`.`team_id` AND (user_id = '#{current_user.id}') AND (evaluate_teams.match_id = #{match_id})")}
end
