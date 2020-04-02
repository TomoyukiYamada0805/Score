class EvaluatesController < ApplicationController
    include Common

    def index
        get_match_info
        
        @evaluate_match = EvaluateMatch.find_by(match_id: @match_id)
        @user           = User.find_by(uid: params[:user_id])
        @like_count     = Like.where(post_user_id: @user.id, match_id: @match_id)
        @like           = Like.where(post_user_id: @user.id, match_id: @match_id, like_user_id: current_user.id) if current_user.present?
    end
end
