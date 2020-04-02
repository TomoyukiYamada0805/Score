class UsersController < ApplicationController
    include Common
    PER = 10

    def show
      get_match_list(model_name: "evaluate_match")
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
      get_match_list(model_name: "like")
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
end
