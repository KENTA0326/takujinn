class Public::PostCommentsController < ApplicationController
  before_action :authenticate_user!

    def create
      @post = Post.find(params[:post_id])
      @post_comment = PostComment.new(post_comment_params)
      @post_comment.user_id = current_user.id
      @post_comment.post_id = @post.id
      @post_comment.save
      # redirect_to post_path(@post)
      # コメントの投稿に対する通知を作成・保存
      @post.create_notification_post_comment!(current_user, @post_comment.id)
    end

    def destroy
      @post_comment = PostComment.find(params[:id])
      @post = @post_comment.post
      @post_comment.destroy
      # redirect_to post_path(params[:post_id])
    end

    private

    def post_comment_params
       params.require(:post_comment).permit(:comment)
    end
end
