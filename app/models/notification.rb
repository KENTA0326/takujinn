class Notification < ApplicationRecord
  include Rails.application.routes.url_helpers
  belongs_to :user
  belongs_to :post, optional: true
  belongs_to :comment, optional: true
  belongs_to :notifiable, polymorphic: true
  belongs_to :visitor, class_name: 'User', foreign_key: 'visitor_id'
  belongs_to :visited, class_name: 'User', foreign_key: 'visited_id'

  def message
    if notifiable_type === "Post"
      "フォローしている#{notifiable.user.name}さんが投稿しました"
    else
      "投稿した#{notifiable.post.text}が#{notifiable.user.name}さんにいいねされました"
    end
  end

  def notifiable_path
    if notification.notifiable_type === "Post"
      post_path(notifiable.id) # 投稿に対する通知の場合はPostの詳細ページへ
    else
      user_path(notifiable.user.id) # いいねに対する通知の場合はいいねをしたUserの詳細ページへ
    end
  end

end
