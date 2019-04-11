class WelcomesController < ApplicationController
  before_action :authenticate_user!, except: [:hello]
  def hello
  end
end
