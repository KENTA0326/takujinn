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
    notices = current_user.passive_notifications # .order(created_at: :desc)
    # @unchecked_notifications = @notices.where(is_checked: false).order(created_at: :desc)

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


    # 通知を確認済みに更新
    # current_user.passive_notifications.update_all(is_checked: true)
    # render "public/notifications/index"
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
