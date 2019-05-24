class TopsController < ApplicationController
  before_action :authenticate_user!, except: [:hello]
  PER = 10

  def hello

    @match = EvaluateMatch.order('evaluate_matches.updated_at DESC').select("matches.*, teams.team_name, users.id as user_id, users.user_name, users.uid, users.avatar, teams.short_name as home_team_name, away_teams_evaluate_matches.short_name as away_team_name, evaluate_matches.updated_at as evaluate_date").left_outer_joins(:match).left_outer_joins(:user).left_outer_joins(:home_team).left_outer_joins(:away_team).page(params[:page]).per(PER)
    @like_count = []
    @user       = []
    @match.each do |match|
      @user.push(User.where(uid: match.uid)[0])
      @like_count.push(Like.where(post_user_id: match[:user_id], match_id: match[:match_id]).size)
    end

    if user_signed_in?
      render "index"
    end
  end

  def index
  end
end
