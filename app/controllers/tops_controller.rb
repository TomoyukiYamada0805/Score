class TopsController < ApplicationController
  def index
    # 後で、matchesテーブルを通してjoinし、2チームのチーム名まで取得す方法を検討する
    @matches = EvaluateMatch.select("*").left_outer_joins(:match).left_outer_joins(:user).all.map{ |p| p.attributes }
    
    @match_content = []
    @matches.each do |match|
      matchInfo = Match.select("matches.section, teams.team_name as home_team_name, away_teams_matches.team_name as away_team_name").where(match_id: match["match_id"]).left_outer_joins(:home_team).left_outer_joins(:away_team).order('matches.id').all.map{ |p| p.attributes }
      match = match.merge(matchInfo[0])
      @match_content.push(match)
    end
  end
end
