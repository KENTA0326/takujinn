class Public::PostsController < ApplicationController
  def index
    @posts = Post.all
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    @post.save
    redirect_to '/posts'
  end

  def show
  end

  private

  def post_params
    params.require(:post).permit(:btype, :location, :text, :user_id)
  end

end
