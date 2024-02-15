class Public::NotificationsController < ApplicationController
  before_action :authenticate_user!

  def index
    notices = current_user.passive_notifications 
    case params[:option]
    when 'uncheck'
      # 未読
      @notifications = notices.where(is_checked: false)
    when 'checked'
      # 既読
      @notifications = notices.where(is_checked: true)
    else
      # すべて
      @notifications = notices
    end

    case params[:range]
    when 'latest'
      # 新しい順
      @notifications = @notifications.order(created_at: :desc)
    when 'oldest'
      # 古い順
      @notifications = @notifications.order(created_at: :asc)
    else
      # latest, oldest以外の文字列の場合
      @notifications = notices.order(created_at: :desc)
    end
  end

  def checked

   @notification = Notification.find(params[:id])
   @notification.update(checked: true, is_checked: true)
   redirect_to notifications_path
  end

  def destroy_all
   @notifications = current_user.passive_notifications
   @checked_notifications = @notifications.where(checked: true)
   @checked_notifications.destroy_all
   redirect_to notifications_path
  end



end
