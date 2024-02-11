class Public::FavoritesController < ApplicationController
  before_action :authenticate_user!

  def index
  end

  def create
    @post = Post.find(params[:post_id])
    favorite = current_user.favorites.new(post_id: @post.id)
    favorite.save
    # redirect_to request.referer #非同期のため削除
     if current_user != @post.user
     @post.create_notification_favorite_post!(current_user)
     end
  end

  def destroy
    @post = Post.find(params[:post_id])
    favorite = current_user.favorites.find_by(post_id: @post.id)
    favorite.destroy
    # redirect_to request.referer#非同期のため削除
  end



end
