module Api
  #
  # ユーザーリソースのコントローラー
  #
  class UsersController < ApplicationController
    skip_before_action :verify_authenticity_token

    # def index
    #   users = XUser.all()
    #   render json: users
    # end

    def show
      id = user_get_params
      user = XUser.find(id)
      render json: user
    end

    def create
      validated_params = user_create_params
      user_params = {
        "email": validated_params[:email],
        "name": validated_params[:name]
      }
      res = XUser.create!(user_params)

      render json: res
    end

    private

    def user_get_params
      params.require(:id)
    end

    def user_create_params
      params.require(:user).permit(:email, :name, :password)
    end
  end
end
