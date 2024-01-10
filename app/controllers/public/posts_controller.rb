class Public::PostsController < ApplicationController
  def index
    @posts = Post.all
    @user = User.find(current_user.id)
  end

  def new
    @post = Post.new
  end
  
  def create
    @post = Post.new(post_params)
    @post.save
    redirect_to '/posts/new'
  end 
  
  def show
  end 
  
  private
  
  def post_params
    params.require(:post).permit(:btype, :location, :text)
  end 
  
end
