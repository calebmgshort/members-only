class PostsController < ApplicationController

  before_action :authenticate_user!, only: [:new, :create]

  def new
    @post = Post.new
  end

  def create
    logger.debug user_signed_in?
    logger.debug current_user
    @post = current_user.posts.build(post_params)
    # logger.debug @post.user

    if @post.save
      logger.debug "succeeded"
      redirect_to posts_url
    else
      logger.debug "failed"
      logger.debug @post.errors.full_messages
      render :new
    end
  end

  def index
    @posts = Post.all
  end

  private
  def post_params
    params.require(:post).permit(:body)
  end
  
end
