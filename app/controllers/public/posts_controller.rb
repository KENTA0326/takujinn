class Public::PostsController < ApplicationController

  def index
    if params[:q].present?
      @q = Post.ransack(params[:q])
      @posts = @q.result(distinct: true)
    else
      @posts = Post.all
    end
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
    @post = Post.find(params[:id])
    @post_comment = PostComment.new
    @post_comments = PostComment.all
  end 
  
  

  private

  def post_params
    params.require(:post).permit(:btype, :location, :text, :user_id)
  end

end
