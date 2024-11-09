# typed: false
module Api
  #
  # Topページ用コントローラー
  #
  class TopController < ApplicationController
    def index
      render action ":index"
    end
  end
end
