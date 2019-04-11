class UsersController < ApplicationController
    def show
      user_id = params[:id]
      @user = User.where(uid: user_id)[0]
      @evaluate = EvaluatePlayer.select("count(*) as count, teams.team_name, teams.team_color").where(user_id: user_id).where("evaluate_point > 0").group("teams.team_name, teams.team_color").left_outer_joins(:player).left_outer_joins(:team)
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
