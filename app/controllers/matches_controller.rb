class MatchesController < ApplicationController

    def list
        @section         = params[:section]
        @latestSection   = Match.maximum("section")
        @nextSection     = @section.to_i + 1 if @section.to_i + 1 < @latestSection
        @previousSection = @section.to_i - 1 if @section.to_i - 1 >= 1

        @match = Match.select("matches.*, teams.short_name as home_team_name ,away_teams_matches.short_name as away_team_name").where(section: @section).left_outer_joins(:home_team).left_outer_joins(:away_team).order('matches.id')
    end

    def show
        match_id = params[:id]
        @create_flg = EvaluateMatch.where(user_id: current_user.uid, match_id: match_id)
        @create_flg = @create_flg[0]
        @match   = Match.where(match_id: match_id)
        @match   = @match[0]
        @team    = MatchInfo.select("*").where(match_id: match_id).left_outer_joins(:team).joins("LEFT OUTER JOIN `evaluate_teams` ON `evaluate_teams`.`team_id` = `match_infos`.`team_id` AND (user_id = '#{current_user.uid}') AND (evaluate_teams.match_id = #{match_id})")
        @player  = MatchPlayer.select("*").where(match_id: match_id).left_outer_joins(:player).joins("LEFT OUTER JOIN `evaluate_players` ON `evaluate_players`.`player_id` = `match_players`.`player_id` AND (user_id = '#{current_user.uid}') AND (evaluate_players.match_id = #{match_id})")
        @coach   = MatchPlayer.select("*").where(match_id: match_id, player_type: 1).joins("LEFT OUTER JOIN `evaluate_coaches` ON `evaluate_coaches`.`coach_name` = `match_players`.`player_name` AND (user_id = '#{current_user.uid}') AND (evaluate_coaches.match_id = #{match_id})")
        @referee = MatchReferee.select("match_referees.referee_name, match_referees.referee_type, evaluate_point").where(match_id: match_id).joins("LEFT OUTER JOIN `evaluate_referees` ON `evaluate_referees`.`referee_name` = `match_referees`.`referee_name` AND (user_id = '#{current_user.uid}') AND (evaluate_referees.match_id = #{match_id})")
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
    end

    def create
        #paramsのpermit
        evaluates = params[:evaluate]
        match_id = request.referer.split("/").last

        registered = EvaluateMatch.where(:user_id => current_user.uid, :match_id => match_id)[0]

        if registered.nil?
          begin
            ActiveRecord::Base.connection.transaction do
              EvaluateMatch.create!(:user_id => current_user.uid, :match_id => match_id)
              
              evaluates.each do |evaluate|
                if evaluate[:team_id].present?
                  EvaluateTeam.create!(:user_id => current_user.uid, :match_id => match_id, :team_id => evaluate[:team_id], :evaluate_point => evaluate[:point].present? ? evaluate[:point].to_f : nil , :evaluate_comment => evaluate[:comment])
                elsif evaluate[:coach_name].present?
                  EvaluateCoach.create!(:user_id => current_user.uid, :match_id => match_id, :coach_name => evaluate[:coach_name], :evaluate_point => evaluate[:point].present? ? evaluate[:point].to_f : nil  )
                elsif evaluate[:player_id].present?
                  EvaluatePlayer.create!(:user_id => current_user.uid, :match_id => match_id, :player_id => evaluate[:player_id], :evaluate_point => evaluate[:point].present? ? evaluate[:point].to_f : nil  )
                elsif evaluate[:referee_name].present?
                  EvaluateReferee.create!(:user_id => current_user.uid, :match_id => match_id, :referee_name => evaluate[:referee_name], :evaluate_point => evaluate[:point].present? ? evaluate[:point].to_f : nil  )
                end
              end
            end
          rescue => e
            logger.info(e.message)
            logger.info("失敗しました")
            flash[:matches_error_message] = e.message
          end
          redirect_to request.referer
        end
    end

    def update
      evaluates = params[:evaluate]
      match_id = request.referer.split("/").last

      begin
        ActiveRecord::Base.connection.transaction do
          #update_atのみ更新
          EvaluateMatch.where(user_id: current_user.uid)[0].touch
    
          evaluates.each do |evaluate|
            if evaluate[:team_id].present?
              EvaluateTeam.where(user_id: current_user.uid, team_id: evaluate[:team_id]).update!(:evaluate_point => evaluate[:point].present? ? evaluate[:point].to_f : nil , :evaluate_comment => evaluate[:comment])
            elsif evaluate[:coach_name].present?
              EvaluateCoach.where(user_id: current_user.uid, coach_name: evaluate[:coach_name]).update!(:evaluate_point => evaluate[:point].present? ? evaluate[:point].to_f : nil )
            elsif evaluate[:player_id].present?
              EvaluatePlayer.where(user_id: current_user.uid, player_id: evaluate[:player_id]).update!(:evaluate_point => evaluate[:point].present? ? evaluate[:point].to_f : nil  )
            elsif evaluate[:referee_name].present?
              EvaluateReferee.where(user_id: current_user.uid, referee_name: evaluate[:referee_name]).update!(:evaluate_point => evaluate[:point].present? ? evaluate[:point].to_f : nil  )
            end
          end
          redirect_to request.referer
        rescue => e
          logger.info(e)
          logger.info("失敗しました")
          @error_message = e.full_messages
          redirect_to request.referer
        end
      end
    end

end
