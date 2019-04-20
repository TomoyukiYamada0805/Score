class TopsController < ApplicationController
  before_action :authenticate_user!, except: [:hello]
  def hello

    if user_signed_in?
      @match = EvaluateMatch.select("matches.*, teams.*, users.id as user_id, users.user_name, users.uid, users.avatar, teams.team_name as home_team_name, away_teams_evaluate_matches.team_name as away_team_name").left_outer_joins(:match).left_outer_joins(:user).left_outer_joins(:home_team).left_outer_joins(:away_team)
      @like_count = []
      @match.each do |match|
        @like_count.push(Like.where(post_user_id: match[:uid], match_id: match[:match_id]).size)
      end
      logger.info(ENV['TWITTER_KEY'])
      render "index"
    end
  end

  def index
  end
end
