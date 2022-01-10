class TweetsController < ApplicationController
  before_action :authenticate_user!, except: [:index]

  def new
    @tweet = Tweet.new
  end

  def create
    @tweet = Tweet.new(tweet_params)
    @tweet.user_id = current_user.id
    #image_file = tweet_params[:image]
    #image_name = image_file.original_filename
    #if image_file.present?
      #image_dir = "images/"
      ##image_dir = Rails.root.join("public", "images")
      #image_path = image_dir + image_name
      
      #bucket_name = "practice-s3-20220110"
      #s3 = Aws::S3::Resource.new
      #bucket = s3.bucket(bucket_name)
      #if bucket.exists?
        #bucket.put_object(acl: "public", key: image_path, body: image_file.read) 
        #@tweet.image = image_path
        ##@tweet.image = "/" + image_path
      #end
      ##File.binwrite(image_path, image_file.read)
    #end
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
      @image_path = @tweet.image
    end
  end
  
  private
  def tweet_params
    params.require(:tweet).permit(:body, :image)
  end

end
