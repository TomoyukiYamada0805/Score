class LikesController < ApplicationController
    def create
        user_id  = request.referer.split("/").last
        match_id = request.referer.split("/")[-3]
        user_id  = request.referer.split("/").last
        create = Like.create!(:post_user_id => user_id, :match_id => match_id, :like_user_id => current_user.uid)
    end

    def delete
        user_id  = request.referer.split("/").last
        match_id = request.referer.split("/")[-3]
        user_id  = request.referer.split("/").last
        delete_post = Like.where(:post_user_id => user_id, :match_id => match_id, :like_user_id => current_user.uid)
        create = Like.find(delete_post[0].id).destroy
    end
end
