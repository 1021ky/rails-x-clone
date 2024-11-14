require 'rails_helper'

RSpec.describe "Users", type: :request do
  before do
    create(:user)
  end

  describe "GET /api/user" do
    it "ユーザー情報が取得できる" do
      get user_api_path
      expect(response).to have_http_status(:success)
    end
  end
end
