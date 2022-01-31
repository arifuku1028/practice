class CommentsController < ApplicationController
  before_action :authenticate_user!, except: [:index]
  
  def new
    @tweet = Tweet.find(params[:tweet_id])
    @comment = Comment.new
  end

  def create
    comment = Comment.new(comment_params)
    comment.save
    redirect_to tweet_comments_path(tweet_id: comment.tweet_id)
  end

  def index
    @tweet = Tweet.find(params[:tweet_id])
    @comments = @tweet.comments
  end
  
  def show
    @comment = Comment.find(params[:id])
    @tweet = @comment.tweet
  end

  def edit
    @comment = Comment.find(params[:id])
    @tweet = @comment.tweet
  end
  
  def update
    comment = Comment.find(params[:id])
    comment.update(comment_params)
    redirect_to tweet_comments_path(tweet_id: comment.tweet_id)
  end
  
  def destroy
    comment = Comment.find(params[:id])
    comment.destroy
    redirect_to tweet_comments_path(tweet_id: comment.tweet_id)
  end
  
  private
  def comment_params
    params.require(:comment).permit(:body).merge(user_id: current_user.id, tweet_id: params[:tweet_id])
  end
  
end
