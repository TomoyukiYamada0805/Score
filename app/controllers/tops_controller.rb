class TopsController < ApplicationController
  before_action :authenticate_user!, except: [:hello]
  include Common

  def hello

    get_match_list(model_name: "evaluate_match")

    if user_signed_in?
      render "index"
    end
  end

  def index
  end
end
