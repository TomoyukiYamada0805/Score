class LikesController < ApplicationController
    def create
        user_id  = request.referer.split("/").last
        user  = User.where(uid: user_id)[0]
        match_id = request.referer.split("/")[-3]
        registered = Like.where(:post_user_id => user.id, :match_id => match_id, :like_user_id => current_user.id)[0]
        if registered.nil?
          create = Like.create!(:post_user_id => user.id, :match_id => match_id, :like_user_id => current_user.id)
        end
        redirect_to request.referer
    end

    def delete
        user_id  = request.referer.split("/").last
        user  = User.where(uid: user_id)[0]
        match_id = request.referer.split("/")[-3]
        delete_post = Like.where(:post_user_id => user.id, :match_id => match_id, :like_user_id => current_user.id)
        create = Like.find(delete_post[0].id).destroy
        redirect_to request.referer
    end
end
