# typed: false
module User
  #
  # ユーザートップのコントローラー
  #
  class TopController < ApplicationController
    def index
      render action ":index"
    end
  end
end
