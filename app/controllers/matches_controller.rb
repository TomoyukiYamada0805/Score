class MatchesController < ApplicationController
    before_action :authenticate_user!, except: :list
    include Common

    def list
        @section         = params[:section]
        @latestSection   = Match.maximum("section")
        @nextSection     = @section.to_i + 1 if @section.to_i + 1 <= @latestSection
        @previousSection = @section.to_i - 1 if @section.to_i - 1 >= 1

        @match = Match.select("matches.*, teams.short_name as home_team_name ,away_teams_matches.short_name as away_team_name").where(section: @section).left_outer_joins(:home_team).left_outer_joins(:away_team).order('matches.id')
    end

    def show
       get_match_info 
    end

    def create
        #paramsのpermit
        evaluates = params[:evaluate]
        @match_id = request.referer.split("/").last

        registered = EvaluateMatch.where(:user_id => current_user.id, :match_id => @match_id)[0]

        if registered.nil?
          team_ids      = []
          player_ids    = []
          coach_names   = []
          referee_names = []

          # Formの情報を変更されたなどで、試合に関係ない情報が入ってくることを制御
          @team    = MatchInfo.get_match_info(current_user, @match_id)
          @player  = MatchPlayer.get_player_info(current_user, @match_id)
          @coach   = MatchPlayer.get_coach_info(current_user, @match_id)
          @referee = MatchReferee.get_referee_info(current_user, @match_id)

          @team.each do |team|
            team_ids.push(team.team_id)
          end

          @player.each do |player|
            player_ids.push(player.players_player_id)
          end

          @coach.each do |coach|
            coach_names.push(coach.player_name)
          end

          @referee.each do |referee|
            referee_names.push(referee.referee_name)
          end

          begin
            ActiveRecord::Base.connection.transaction do
              EvaluateMatch.create!(:user_id => current_user.id, :match_id => @match_id)
              
              evaluates.each do |evaluate|
                if evaluate[:team_id].present?
                  if team_ids.include?(evaluate[:team_id].to_i)
                    team_ids.delete(evaluate[:team_id].to_i)
                    EvaluateTeam.create!(:user_id => current_user.id, :match_id => @match_id, :team_id => evaluate[:team_id], :evaluate_point => evaluate[:point].present? ? evaluate[:point].to_f : nil , :evaluate_comment => evaluate[:comment])
                  else
                    raise
                  end
                elsif evaluate[:coach_name].present?
                  if coach_names.include?(evaluate[:coach_name])
                    coach_names.delete(evaluate[:coach_name])
                    EvaluateCoach.create!(:user_id => current_user.id, :match_id => @match_id, :coach_name => evaluate[:coach_name], :evaluate_point => evaluate[:point].present? ? evaluate[:point].to_f : nil  )
                  else
                    raise
                  end
                elsif evaluate[:player_id].present?
                  if player_ids.include?(evaluate[:player_id].to_i)
                    player_ids.delete(evaluate[:player_id].to_i)
                    EvaluatePlayer.create!(:user_id => current_user.id, :match_id => @match_id, :player_id => evaluate[:player_id], :evaluate_point => evaluate[:point].present? ? evaluate[:point].to_f : nil  )
                  else
                    raise
                  end
                elsif evaluate[:referee_name].present?
                  if referee_names.include?(evaluate[:referee_name])
                    referee_names.delete(evaluate[:referee_name])
                    EvaluateReferee.create!(:user_id => current_user.id, :match_id => @match_id, :referee_name => evaluate[:referee_name], :evaluate_point => evaluate[:point].present? ? evaluate[:point].to_f : nil  )
                  else
                    raise
                  end
                end
              end
            end

          rescue => e
            logger.info(e.message)
            logger.info("失敗しました")
            flash[:matches_error_message] = e.message
          end
          flash[:alert] = "登録完了しました"
          redirect_to request.referer
        end
    end

    def update
      evaluates = params[:evaluate]
      match_id = request.referer.split("/").last
      team_ids      = []
      player_ids    = []
      coach_names   = []
      referee_names = []

      begin
        ActiveRecord::Base.connection.transaction do
          #update_atのみ更新
          EvaluateMatch.where(user_id: current_user.id)[0].touch
    
          evaluates.each do |evaluate|
            if evaluate[:team_id].present?
              EvaluateTeam.where(user_id: current_user.id, team_id: evaluate[:team_id], match_id: match_id).update(:evaluate_point => evaluate[:point].present? ? evaluate[:point].to_f : nil , :evaluate_comment => evaluate[:comment])
            elsif evaluate[:coach_name].present?
              EvaluateCoach.where(user_id: current_user.id, coach_name: evaluate[:coach_name], match_id: match_id).update(:evaluate_point => evaluate[:point].present? ? evaluate[:point].to_f : nil )
            elsif evaluate[:player_id].present?
              EvaluatePlayer.where(user_id: current_user.id, player_id: evaluate[:player_id], match_id: match_id).update(:evaluate_point => evaluate[:point].present? ? evaluate[:point].to_f : nil  )
            elsif evaluate[:referee_name].present?
              EvaluateReferee.where(user_id: current_user.id, referee_name: evaluate[:referee_name], match_id: match_id).update(:evaluate_point => evaluate[:point].present? ? evaluate[:point].to_f : nil  )
            end
          end
          flash[:alert] = "更新完了しました"
        rescue => e
          logger.info(e)
          logger.info("失敗しました")
          @error_message = e.message
        end
        redirect_to request.referer
      end
    end

end
