class Public::UsersController < ApplicationController
  before_action :set_search
  before_action :ensure_guest_user, only: [:edit]
  def index
    if params[:q].present?
      @q = User.ransack(params[:q])
      @users = @q.result(distinct: true)
    else
    @users = User.all
    end
  end

  def mypage
    @user = current_user
  end

  def show
    @user = User.find(params[:id])
    @currentUserEntry=Entry.where(user_id: current_user.id)
    @userEntry=Entry.where(user_id: @user.id)
    if @user.id == current_user.id
    else
      @currentUserEntry.each do |cu|
        @userEntry.each do |u|
          if cu.room_id == u.room_id then
            @isRoom = true
            @roomId = cu.room_id
          end
        end
      end
      if @isRoom
      else
        @room = Room.new
        @entry = Entry.new
      end
    end
  end

   def favorites
    @user = User.find(params[:id])
    favorites = Favorite.where(user_id: @user.id).pluck(:post_id)
    @favorite_posts = Post.find(favorites)
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

  def create
    @user = User.new(user_params)
    p "aaaaaaaaaaa"
    p user_params

    if @user.save
      # ユーザーが正常に作成された場合の処理
      redirect_to users_path, notice: 'ユーザーが正常に作成されました。'
    else
      # ユーザーの作成に失敗した場合の処理
      render :new
    end
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

  def unsubscribe
    @user = current_user
  end

  def withdraw
    @user = current_user
    # is_deletedカラムをtrueに変更することにより削除フラグを立てる
    # @user.update(user_status: false)
    @user.destroy
    reset_session
    flash[:notice] = "退会処理を実行いたしました"
    redirect_to root_path
  end

  def set_search
    @q = User.ransack(params[:q])
    @users = @q.result(distinct: true).order(created_at: :desc)
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