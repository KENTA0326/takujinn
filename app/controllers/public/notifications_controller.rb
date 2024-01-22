class Public::NotificationsController < ApplicationController
  before_action :authenticate_user!

  # def index
  #   @notifications = current_user.passive_notifications.where(checked: false).order(created_at: :desc).page(params[:page]).per(6)
  # end

  # def mark_as_read
  #   current_user.passive_notifications.where(checked: false).update_all(checked: true)
  #   redirect_to request.referer, notice: "すべて既読にしました"
  # end

  # def update
  #   notification = Notification.find(params[:id])
  #   notification.update(checked: true)
  #   redirect_to request.referer
  # end

  def index
    @user = current_user
    @notices = current_user.passive_notifications.order(created_at: :desc)
    @unchecked_notifications = @notices.where(is_checked: false)

    # 確認済みの通知を取得
    @checked_notifications = @notices.where(is_checked: true).limit(20)

    # 通知を確認済みに更新
    current_user.passive_notifications.update_all(is_checked: true)
    render "public/notifications/index"
  end

  def update_checked
    current_user.passive_notifications.update_all(is_checked: true)
    head :no_content
  end

  # def update
  #   notification = current_user.notifications.find(params[:id])
  #   notification.update(read: true)
  #   redirect_to notification.notifiable_path
  # end
end
