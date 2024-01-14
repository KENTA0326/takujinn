class Public::PostCommentsController < ApplicationController
    def create
      @post = Post.find(params[:post_id])
      @post_comment = PostComment.new(post_comment_params)
      @post_comment.user_id = current_user.id
      @post_comment.post_id = @post.id
      @post_comment.save
      # redirect_to post_path(@post)
    end

    def destroy
      PostComment.find(params[:id]).destroy
      # redirect_to post_path(params[:post_id])
    end

    private

    def post_comment_params
       params.require(:post_comment).permit(:comment)
    end
end
