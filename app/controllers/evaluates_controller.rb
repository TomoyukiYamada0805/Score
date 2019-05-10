class EvaluatesController < ApplicationController
    def index
        match_id = params[:match_id]
        @user    = User.where(uid: params[:user_id])[0]
        @match   = Match.where(match_id: match_id)[0]
        @team    = MatchInfo.select("*").where(match_id: match_id).left_outer_joins(:team).joins("LEFT OUTER JOIN `evaluate_teams` ON `evaluate_teams`.`team_id` = `match_infos`.`team_id` AND (user_id = '#{@user.id}') AND (evaluate_teams.match_id = #{match_id})")
        @player  = MatchPlayer.select("*").where(match_id: match_id).left_outer_joins(:player).joins("LEFT OUTER JOIN `evaluate_players` ON `evaluate_players`.`player_id` = `match_players`.`player_id` AND (user_id = '#{@user.id}') AND (evaluate_players.match_id = #{match_id})")
        @coach   = MatchPlayer.select("*").where(match_id: match_id, player_type: 1).joins("LEFT OUTER JOIN `evaluate_coaches` ON `evaluate_coaches`.`coach_name` = `match_players`.`player_name` AND (user_id = '#{@user.id}') AND (evaluate_coaches.match_id = #{match_id})")
        @referee = MatchReferee.select("*").where(match_id: match_id).joins("LEFT OUTER JOIN `evaluate_referees` ON `evaluate_referees`.`referee_name` = `match_referees`.`referee_name` AND (user_id = '#{@user.id}') AND (evaluate_referees.match_id = #{match_id})")
        @progress = MatchProgress.where(match_id: match_id)

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
        @like_count = Like.where(post_user_id: @user.id, match_id: params[:match_id])
        @like = Like.where(post_user_id: @user.id, match_id: params[:match_id], like_user_id: current_user.id) if current_user.present?
    end
end
