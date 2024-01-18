class Post < ApplicationRecord
 validates :user_id, {presence: true}
 belongs_to :user
 has_many :favorites, dependent: :destroy
 has_many :notifications, as: :notifiable, dependent: :destroy #追記  :
 has_many :post_comments, dependent: :destroy
 after_create do
    user.followers.each do |follower|
      notifications.create(user_id: follower.id)
    end
  end

 def favorited_by?(user)
   favorites.exists?(user_id: user.id)
 end 
 
  # postへのいいね通知機能
 def create_notification_favorite_post!(current_user)
   # 同じユーザーが同じ投稿に既にいいねしていないかを確認
   existing_notification = Notification.find_by(post_id: self.id, visitor_id: current_user.id, action: "favorite_post")
   
   # すでにいいねされていない場合のみ通知レコードを作成
   if existing_notification.nil? && current_user != self.user
     notification = Notification.new(
       post_id: self.id,
       visitor_id: current_user.id,
       visited_id: self.user.id,
       action: "favorite_post"
     )

     if notification.valid?
       notification.save
     end
   end
 end

end
