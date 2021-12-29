class TweetsController < ApplicationController

  def new
    @tweet = Tweet.new
  end

  def create
    
  end
  
  def index
    @tweets = Tweet.all
  end

  def show
    @tweet = Tweet.find(params[:id])
  end

end
