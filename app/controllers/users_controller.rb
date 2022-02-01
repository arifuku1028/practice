class UsersController < ApplicationController

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @tweets = @user.tweets
    @favorite_tweets = @user.favorite_tweets
    @comment_tweets = @user.comment_tweets
  end
  
  def follows
    @following_user = User.find(params[:id])
    @users = @following_user.followings
  end
  
  def followers
    @followed_user = User.find(params[:id])
    @users = @followed_user.followers
  end

end
