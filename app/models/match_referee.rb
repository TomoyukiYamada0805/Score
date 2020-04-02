class MatchReferee < ApplicationRecord
    scope :get_referee_info, -> (current_user, match_id) { select("match_referees.referee_name, match_referees.referee_type, evaluate_point").where(match_id: match_id).joins("LEFT OUTER JOIN `evaluate_referees` ON `evaluate_referees`.`referee_name` = `match_referees`.`referee_name` AND (user_id = '#{current_user.id}') AND (evaluate_referees.match_id = #{match_id})") }
end
