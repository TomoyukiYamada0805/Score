module Common
  extend ActiveSupport::Concern

  def get_match_list(model_name:)
    per = 10
    uid            = params[:id]
    @user          = User.find_by(uid: uid)
    @like_count    = []
    @evaluate_user = []

    @evaluate = EvaluatePlayer.select("count(*) as count, teams.short_name, teams.team_color")
                              .where("evaluate_point > 0")
                              .group("teams.short_name, teams.team_color")
                              .left_outer_joins(:player)
                              .left_outer_joins(:team)

    @match = Match.order('evaluate_matches.updated_at DESC')
                  .select("matches.*, users.id as user_id, users.user_name, users.uid, users.avatar, teams.short_name as home_team_name, away_teams_matches.short_name as away_team_name, evaluate_matches.updated_at as evaluate_date")
                  .joins(:"#{model_name}")
                  .left_outer_joins(:user)
                  .left_outer_joins(:home_team)
                  .left_outer_joins(:away_team)
                  .page(params[:page])
                  .per(per)

    if uid.present?
        @evaluate.where(user_id: @user.id)
        @match.where(user_id: @user.id)
    end

    @match.each do |match|
      @evaluate_user.push(User.find_by(uid: match.uid))
      @like_count.push(Like.where(post_user_id: match[:user_id], match_id: match[:match_id]).size)
    end
  end

  def get_match_info
    @match_id = params[:id]
    @create_flg = EvaluateMatch.find_by(user_id: current_user.id, match_id: @match_id)
    @match   = Match.find_by(match_id: @match_id)
    @team    = MatchInfo.get_match_info(current_user, @match_id)
    @player  = MatchPlayer.get_player_info(current_user, @match_id)
    @coach   = MatchPlayer.get_coach_info(current_user, @match_id)
    @referee = MatchReferee.get_referee_info(current_user, @match_id)
    @progress = MatchProgress.where(match_id: @match_id)

    @homeTeamInfo = {}
    @awayTeamInfo = {}

    #テーム情報
    @team.each do |team|
        if team.team_type == 0
            @homeTeamInfo = team
        else
            @awayTeamInfo = team
        end
    end

    @homeTeamPlayer    = []
    @homeTeamSubPlayer = []
    @awayTeamPlayer    = []
    @awayTeamSubPlayer = []

    # 選手
    @player.each do |player|
        playerContent = {}
        # Home starting member
        if player.team_type == 0 && player.starting_flg == 1 && player.player_type == 0
            @homeTeamPlayer.push(player)
        
        # Away starting memeber
        elsif player.team_type == 1 && player.starting_flg == 1 && player.player_type == 0
            @awayTeamPlayer.push(player)

        # Home substitute member
        elsif player.team_type == 0 && player.starting_flg == 0 && player.player_type == 0
            @homeTeamSubPlayer.push(player)

        elsif player.team_type == 1 && player.starting_flg == 0 && player.player_type == 0
            @awayTeamSubPlayer.push(player)
        end
    end

    logger.info('aaaaaaaaaaaa')
    logger.info(@player[0].inspect)

    # 監督
    @coach.each do |coach|
    
        if coach.team_type == 0
          @homeTeamCoach = coach
        else
          @awayTeamCoach = coach
        end
    end

    # 審判
    @assistantReferee = []
    @referee.each do |referee|
    
        if referee.referee_type == 0
          @chiefReferee = referee
        else
          @assistantReferee.push(referee)
        end
    end
  end

end