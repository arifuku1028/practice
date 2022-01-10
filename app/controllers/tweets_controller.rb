class TweetsController < ApplicationController
  before_action :authenticate_user!, except: [:index]

  def new
    @tweet = Tweet.new
  end

  def create
    @tweet = Tweet.new(tweet_params)
    @tweet.user_id = current_user.id
    image_file = tweet_params[:image]
    tweet_name = image_file.original_filename
    @tweet.image = tweet_name
    if image_file.present?
      image_dir = Rails.root.join("public", "images")
      image_path = image_dir + tweet_name
      File.binwrite(image_path, image_file.read)
    end
    @tweet.save
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
      image_dir = "/images/"
      @image_path = image_dir + @tweet.image
    end
  end
  
  private
  def tweet_params
    params.require(:tweet).permit(:body, :image)
  end

end
