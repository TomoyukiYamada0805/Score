class Match < ApplicationRecord
    belongs_to :evaluate_match, primary_key: :match_id, foreign_key: :match_id 
    belongs_to :home_team, class_name: "Team", primary_key: :home_team_id, foreign_key: :team_id
    belongs_to :away_team, class_name: "Team",primary_key: :away_team_id, foreign_key: :team_id
    has_many :match_info, primary_key: :match_id, foreign_key: :match_id
    has_many :home_team, class_name: "Team", primary_key: :home_team_id, foreign_key: :team_id
    has_many :away_team, class_name: "Team",  primary_key: :away_team_id, foreign_key: :team_id
    has_many :match_player, primary_key: :match_id, foreign_key: :match_id
    has_many :user, through: :evaluate_match
    has_many :like, primary_key: :match_id, foreign_key: :match_id

    #has_many :player, through: :match_player
end
