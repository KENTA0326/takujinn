class Public::MessagesController < ApplicationController
before_action :authenticate_user!, :only => [:create]

  def create
    if Entry.where(:user_id => current_user.id, :room_id => params[:message][:room_id]).present?
      @message = Message.create(params.require(:message).permit(:message,:user_id, :content, :room_id).merge(:user_id => current_user.id))
      
      # 新規作成された@messageに紐づくroomを@roomに格納する
      @room = @message.room
      # 本引数を２つ持たせてcreate_notification_dmメソッドを実行
      @room.create_notification_dm(current_user, @message.id)
      redirect_to "/rooms/#{@message.room_id}"
    else
      redirect_back(fallback_location: root_path)
    end
  end
end
