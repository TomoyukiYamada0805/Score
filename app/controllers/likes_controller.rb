class LikesController < ApplicationController
    def create
        user_id  = request.referer.split("/").last
        match_id = request.referer.split("/")[-3]
        user_id  = request.referer.split("/").last
        registered = Like.where(:post_user_id => user_id, :match_id => match_id, :like_user_id => current_user.uid)[0]
        if registered.nil?
          create = Like.create!(:post_user_id => user_id, :match_id => match_id, :like_user_id => current_user.uid)
        end
        redirect_to request.referer
    end

    def delete
        user_id  = request.referer.split("/").last
        match_id = request.referer.split("/")[-3]
        user_id  = request.referer.split("/").last
        delete_post = Like.where(:post_user_id => user_id, :match_id => match_id, :like_user_id => current_user.uid)
        create = Like.find(delete_post[0].id).destroy
        redirect_to request.referer
    end
end
