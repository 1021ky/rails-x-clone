# typed: false
class Api::TopController < ApplicationController
  def index
    render action ":index"
  end
end
