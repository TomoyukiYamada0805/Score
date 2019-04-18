class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :basic_auth
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :latest_match_list
  before_action :get_current_user_info

  def get_current_user_info
    @login_user = User.where(uid: current_user.uid)[0] if current_user.present?
  end

  def after_sign_in_path_for(resource)
    tops_path
  end

  def latest_match_list
    @section = Match.maximum("section")
    @latest_match = Match.select("matches.*, teams.short_name as home_team_name ,away_teams_matches.short_name as away_team_name").where(section: @section).left_outer_joins(:home_team).left_outer_joins(:away_team).order('matches.id')
  end

  protected

  def configure_permitted_parameters
    added_attrs = [ :email, :user_name, :password, :password_confirmation, :avatar ]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    devise_parameter_sanitizer.permit :account_update, keys: added_attrs
    devise_parameter_sanitizer.permit :sign_in, keys: added_attrs
  end

  def basic_auth
    authenticate_or_request_with_http_basic do |username, password|
      username == "kengonakamura" && password == "0363!"
    end
  end
end
