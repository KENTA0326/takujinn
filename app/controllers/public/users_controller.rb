class Public::UsersController < ApplicationController
  before_action :ensure_guest_user, only: [:edit]
  def index
    @user = current_user
  end

  def show
    @user = User.find(params[:id])
    #@post = Post.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
    if @user !=current_user
      flash[:notice] = "編集する権限がありません"
      redirect_to user_path(current_user.id)
    end
  end

  def confirm
  end

  def update
    if current_user.update(user_params)
      flash[:notice] = '変更が保存されました。'
      redirect_to users_path
    else
      flash.now[:alert] = "変更に失敗しました。"
      render edit_user_path(current_user)
    end
  end

  private

  def ensure_guest_user
    @user = User.find(params[:id])
    if @user.guest_user?
      redirect_to user_path(current_user) , notice: "ゲストユーザーはプロフィール編集画面へ遷移できません。"
    end
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :year, :btype, :introduction, :addresses, :telephone)
  end

end
