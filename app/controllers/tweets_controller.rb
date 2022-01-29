class TweetsController < ApplicationController
  before_action :authenticate_user!, except: [:index]

  def new
    @tweet = Tweet.new
  end

  def create
    tweet = Tweet.new(tweet_params)
    tweet.user_id = current_user.id
    tweet.save
    redirect_to tweets_path
  end
  
  def index
    @tweets = Tweet.all
  end

  def show
    @tweet = Tweet.find(params[:id])
    @user = @tweet.user
    @comments = @tweet.comments
    if @tweet.image
      @image_path = @tweet.image
    end
  end
  
  def edit
    @tweet = Tweet.find(params[:id])
  end
  
  def update
    tweet = Tweet.find(params[:id])
    tweet.body = tweet_params[:body]
    if tweet_params[:image]
      tweet.image = tweet_params[:image]
    end
    tweet.save
    redirect_to tweet_path(id: tweet.id)
  end
  
  def destroy
    tweet = Tweet.find(params[:id])
    comments = tweet.comments 
    favorites = tweet.favorites
    comments.each do |comment|
      comment.destroy
    end
    favorites.each do |favorite|
      favorite.destroy
    end
    tweet.destroy
    redirect_to tweets_path
  end
  
  private
  def tweet_params
    params.require(:tweet).permit(:body, :image)
  end

end
