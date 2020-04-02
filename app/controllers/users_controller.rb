class UsersController < ApplicationController
    include Common
    PER = 10

    def show
      get_match_list(model_name: "evaluate_match")
      @evaluate_ranking = EvaluatePlayer.get_evaluate_ranking(@user)
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
