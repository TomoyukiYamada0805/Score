module ApplicationHelper
    #なぜか、avatarのファイルパスつき情報が取得できないので、調査する必要あり
    def image_path(image_name, user_id)
        image_name.present? ? "/uploads/user/avatar/#{user_id}/thumb_#{image_name}" : "/assets/icon.jpg"
    end
end
