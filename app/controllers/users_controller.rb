class UsersController < ApplicationController
    def show
      user_id = params[:id]
      @user = User.where(uid: user_id)[0]
      @evaluate = EvaluatePlayer.select("count(*) as count, teams.team_name, teams.team_color").where(user_id: user_id).where("evaluate_point > 0").group("teams.team_name, teams.team_color").left_outer_joins(:player).left_outer_joins(:team)
      @match = EvaluateMatch.select("matches.*, teams.*, users.id as user_id, users.user_name, users.uid, users.avatar, teams.team_name as home_team_name, away_teams_evaluate_matches.team_name as away_team_name").where(user_id: user_id).left_outer_joins(:match).left_outer_joins(:user).left_outer_joins(:home_team).left_outer_joins(:away_team)
      @like_count = []
      @match.each do |match|
        @like_count.push(Like.where(post_user_id: match[:uid], match_id: match[:match_id]).size)
      end
      @evaluate_ranking = EvaluatePlayer.select("AVG(evaluate_point) as point, evaluate_players.player_id, players.player_name, teams.team_name").where(user_id: user_id).left_outer_joins(:player).left_outer_joins(:team).group("evaluate_players.player_id, players.player_name, `evaluate_players`.`evaluate_point`, teams.team_name").order(evaluate_point: "DESC").limit(3)
    end

    def edit
    end

    def update
      p user_params
      respond_to do |format|
        if @user.update_without_current_password(user_params)
          format.html { redirect_to @user, notice: 'User was successfully updated.' }
          format.json { render :show, status: :ok, location: @user }
        else
          format.html { render :edit }
          format.json { render json: @user.errors, status: :unprocessable_entity }
        end
      end
        #begin
        #  @user = User.where(uid: current_user.uid).update(user_params)
        #  File.open("text_write_test.txt","w") do |text|
        #   text.puts(@user.inspect)
        #  end
        #rescue => e
        #    File.open("text_write_test.txt","w") do |text|
        #     text.puts(e)
        #    end
        #end
    end

    def user_params
      params.permit(:user_name)
    end
end
