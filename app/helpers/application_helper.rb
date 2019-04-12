module ApplicationHelper
    #なぜか、avatarのファイルパスつき情報が取得できないので、調査する必要あり
    def image_path(user_id, image_name)
        "/uploads/user/avatar/#{user_id}/thumb_#{image_name}"
    end
end
