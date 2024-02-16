class Public::PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_search

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
    if @post.save
      flash[:success] = '投稿が完了しました。'
      redirect_to '/posts'
    else
      render :new
    end
  end

  def show
    @post = Post.find(params[:id])
    @post_comment = PostComment.new
    @post_comments = PostComment.all
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      flash[:notice]="投稿情報を更新しました"
      redirect_to posts_path(@post)
    else
      render :edit
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    flash[:notice]="投稿を削除しました"
    redirect_to posts_path
  end

  def set_search
    @q = Post.ransack(params[:q])
    @posts = @q.result(distinct: true).order(created_at: :desc)
  end #

  private

  def post_params
    params.require(:post).permit(:btype, :location, :text, :user_id)
  end

end
