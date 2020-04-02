class EvaluatePlayer < ApplicationRecord
    has_many :player, primary_key: :player_id, foreign_key: :player_id
    has_many :team, through: :player

    scope :get_evaluate_ranking, -> (user){select("AVG(evaluate_players.evaluate_point) as point, evaluate_players.player_id, players.player_name, teams.short_name").where(user_id: user.id).where("evaluate_point > 0").left_outer_joins(:player).left_outer_joins(:team).group("evaluate_players.player_id, players.player_name, `evaluate_players`.`evaluate_point`, teams.short_name").order(evaluate_point: "DESC").limit(3)}
end
