# This file contains request specs for the Users API

RSpec.describe "Users API", type: :request do
  shared_context "DBにユーザー情報があるとき" do
    let!(:user1) { create(:x_user) }
    let!(:user2) { create(:x_user) }
  end

  describe "GET /api/user endpoint" do
    include_context "DBにユーザー情報があるとき"
    it "ユーザーIDを指定して取得できる" do
      get api_user_path(user1.id)
      expect(response).to have_http_status(:success)
      expect(JSON.parse(response.body)["id"]).to eq(user1.id)
    end
  end
end
