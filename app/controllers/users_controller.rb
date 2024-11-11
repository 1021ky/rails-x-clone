module Api
  #
  # ユーザーリソースのコントローラー
  #
  class UsersController < ApplicationController
    skip_before_action :verify_authenticity_token

    def index
      id = params[:id]
      user = XUser.find(id)
      render json: user
    end

    def create
      validated_param = create_user_params
      res = XUser.create!(validated_param)
      render json: res
    end

    private

    def create_user_params
      params.require(:user).permit(:email, :name, :password)
    end
  end
end
