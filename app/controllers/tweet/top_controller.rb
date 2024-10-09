# typed: true

#
# Tweet::TopController
#
class Tweet::TopController < ApplicationController
  def index
    render action: 'index'
  end

  def create
    @tweet = Tweet.new(tweet_create_params)
    if @tweet.save
      redirect_to tweet_top_index_path
    else
      render action: 'index'
    end
  end

  private

  def tweet_create_params
    params.require(:tweet).permit(:x_user_id, :content)
  end
end
