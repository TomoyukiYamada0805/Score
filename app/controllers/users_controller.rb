class UsersController < ApplicationController
    PER = 10

    def show
      user_id = params[:id]
      @user = User.where(uid: user_id)[0]
      @evaluate = EvaluatePlayer.select("count(*) as count, teams.short_name, teams.team_color").where(user_id: user_id).where("evaluate_point > 0").group("teams.short_name, teams.team_color").left_outer_joins(:player).left_outer_joins(:team)
      @match = EvaluateMatch.select("matches.*, teams.*, users.id as user_id, users.user_name, users.uid, users.avatar, teams.short_name as home_team_name, away_teams_evaluate_matches.short_name as away_team_name").where(user_id: user_id).left_outer_joins(:match).left_outer_joins(:user).left_outer_joins(:home_team).left_outer_joins(:away_team).page(params[:page]).per(PER)
      @like_count = []
      @evaluate_user = []
      @match.each do |match|
        @evaluate_user.push(User.where(uid: match.uid)[0])
        @like_count.push(Like.where(post_user_id: match[:uid], match_id: match[:match_id]).size)
      end
      @evaluate_ranking = EvaluatePlayer.select("AVG(evaluate_point) as point, evaluate_players.player_id, players.player_name, teams.short_name").where(user_id: user_id).where("evaluate_point > 0").left_outer_joins(:player).left_outer_joins(:team).group("evaluate_players.player_id, players.player_name, `evaluate_players`.`evaluate_point`, teams.short_name").order(evaluate_point: "DESC").limit(3)
    end

    def like
      user_id = params[:id]
      @like_matches = Like.where(like_user_id: user_id).page(params[:page]).per(PER)
      @match = []
      @like_count = []
      @evaluate_user = []
      @like_matches.each do |match|
        @evaluate_user.push(User.where(uid: match.uid)[0])
        like = EvaluateMatch.select("matches.*, teams.*, users.id as user_id, users.user_name, users.uid, users.avatar, teams.short_name as home_team_name, away_teams_evaluate_matches.short_name as away_team_name").where(user_id: match.post_user_id, match_id: match.match_id).left_outer_joins(:match).left_outer_joins(:user).left_outer_joins(:home_team).left_outer_joins(:away_team)[0]
        @match.push(like)
        @like_count.push(Like.where(post_user_id: like[:uid], match_id: like[:match_id]).size)
      end

      @user = User.where(uid: user_id)[0]
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

    def following
      @user = User.find(params[:id])
      @users = @user.following
      render 'show_follow'
    end

    def followers
      @user = User.find(params[:id])
      @users = @user.followers
      render 'show_follower'
    end
end
