require 'rails_helper'

RSpec.describe "Users", type: :request do

  describe "GET /api/user" do
    context "ユーザー情報がDBにあるとき" do
      let!(:user) {create(:x_user)}
      it "ユーザー情報が取得できる" do
        p api_users_path
        get api_users_path
        expect(response).to have_http_status(:success)
      end
    end
  end
end
#