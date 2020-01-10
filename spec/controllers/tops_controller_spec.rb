require 'rails_helper'

RSpec.describe TopsController, type: :controller do

  it "returns a 200 response" do
    get :index
      expect(response).to have_http_status "200"
  end

end
