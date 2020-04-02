class UsersController < ApplicationController
    PER = 10

    def show
      get_match_info(model_name: "evaluate_match")
      @evaluate_ranking = EvaluatePlayer.select("AVG(evaluate_players.evaluate_point) as point, evaluate_players.player_id, players.player_name, teams.short_name")
                                        .where(user_id: @user.id)
                                        .where("evaluate_point > 0")
                                        .left_outer_joins(:player)
                                        .left_outer_joins(:team)
                                        .group("evaluate_players.player_id, players.player_name, `evaluate_players`.`evaluate_point`, teams.short_name")
                                        .order(evaluate_point: "DESC")
                                        .limit(3)
    end

    def like
      get_match_info(model_name: "like")
    end

    def edit
    end

    def update
      respond_to do |format|
        if @user.update_without_current_password(user_params)
          format.html { redirect_to @user, notice: 'User was successfully updated.' }
          format.json { render :show, status: :ok, location: @user }
        else
          format.html { render :edit }
          format.json { render json: @user.errors, status: :unprocessable_entity }
        end
      end
    end

    def confirmation
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

    private

    def get_match_info(model_name:)
      uid            = params[:id]
      @user          = User.find_by(uid: uid)
      @like_count    = []
      @evaluate_user = []

      @evaluate = EvaluatePlayer.select("count(*) as count, teams.short_name, teams.team_color")
                                .where(user_id: @user.id)
                                .where("evaluate_point > 0")
                                .group("teams.short_name, teams.team_color")
                                .left_outer_joins(:player)
                                .left_outer_joins(:team)
                                
      @match = Match.order('evaluate_matches.updated_at DESC').select("matches.*, users.id as user_id, users.user_name, users.uid, users.avatar, teams.short_name as home_team_name, away_teams_matches.short_name as away_team_name, evaluate_matches.updated_at as evaluate_date").where(users: {id: @user.id}).joins(:"#{model_name}").left_outer_joins(:user).left_outer_joins(:home_team).left_outer_joins(:away_team).page(params[:page]).per(PER)

      @match.each do |match|
        @evaluate_user.push(User.where(uid: match.uid)[0])
        @like_count.push(Like.where(post_user_id: match[:user_id], match_id: match[:match_id]).size)
      end
    end
end
