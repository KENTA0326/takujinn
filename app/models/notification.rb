class Notification < ApplicationRecord
  default_scope -> { order(created_at: "DESC") }

  belongs_to :post, optional: true
  belongs_to :pose_comment, optional: true
  belongs_to :favorite, optional: true
  belongs_to :relationship, optional: true

  belongs_to :visitor, class_name: "User", foreign_key: "visitor_id", optional: true
  belongs_to :visited, class_name: "User", foreign_key: "visited_id", optional: true


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
