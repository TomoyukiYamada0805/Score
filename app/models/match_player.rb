class MatchPlayer < ApplicationRecord
    belongs_to :match, primary_key: :match_id, foreign_key: :match_id
    has_many :player, primary_key: :player_id, foreign_key: :player_id

    scope :get_player_info, -> (current_user, match_id) { select("*, players.player_id as players_player_id").where(match_id: match_id).left_outer_joins(:player).joins("LEFT OUTER JOIN `evaluate_players` ON `evaluate_players`.`player_id` = `match_players`.`player_id` AND (user_id = '#{current_user.id}') AND (evaluate_players.match_id = #{match_id})")}
    scope :get_coach_info, -> (current_user, match_id) { select("*").where(match_id: match_id, player_type: 1).joins("LEFT OUTER JOIN `evaluate_coaches` ON `evaluate_coaches`.`coach_name` = `match_players`.`player_name` AND (user_id = '#{current_user.id}') AND (evaluate_coaches.match_id = #{match_id})") }
end
