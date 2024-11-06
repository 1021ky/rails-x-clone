# typed: true

module Api
  #
  # Api::TweetController
  #
  #
  # Tweetリソースのルートコントローラー
  #
  class TweetController < ApplicationController
    skip_before_action :verify_authenticity_token

    def index
      render action: 'index'
    end

    def create
      @tweet = Tweet.new(tweet_create_params)
      if @tweet.save
        redirect_to api_tweet_index_path
      else
        render action: 'index'
      end
    end

    private

    def tweet_create_params
      params.require(:tweet).permit(:x_user_id, :content)
    end
  end
end
