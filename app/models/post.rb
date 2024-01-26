class Post < ApplicationRecord
  validates :user_id, presence: true
  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :notifications, as: :notifiable, dependent: :destroy
  has_many :post_comments, dependent: :destroy
  has_one_attached :image

  after_create do
    user.followers.each do |follower|
      Notification.create(post_id: self.id, visited_id: follower.id, visitor_id: user.id, action: "create_post")
    end
  end

  def self.ransackable_attributes(auth_object = nil)
    %w[btype location]
  end

  def self.ransackable_associations(auth_object = nil)
    []
  end

  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end

  # postへのいいね通知機能
  def create_notification_favorite_post!(current_user)
    # 同じユーザーが同じ投稿に既にいいねしていないかを確認
    existing_notification = Notification.find_by(post_id: id, visitor_id: current_user.id, action: "favorite_post")

    # すでにいいねされていない場合のみ通知レコードを作成
    if existing_notification.nil? && current_user != user
      notification = Notification.new(
        post_id: id,
        visitor_id: current_user.id,
        visited_id: user.id,
        action: "favorite_post"
      )

      notification.save if notification.valid?
    end
  end

  # コメントが投稿された際に通知を作成するメソッド
  def create_notification_post_comment!(current_user, post_comment_id)
    # 自分以外にコメントしている人をすべて取得し、全員に通知を送る
    other_post_commenters_ids = PostComment.where(post_id: id).where.not(user_id: current_user.id).distinct.pluck(:user_id)
    # 各コメントユーザーに対して通知を作成
    other_post_commenters_ids.each do |post_commenter_id|
      save_notification_post_comment!(current_user, post_comment_id, post_commenter_id)
    end

    # まだ誰もコメントしていない場合は、投稿者に通知を送る
    save_notification_post_comment!(current_user, post_comment_id, user_id) if other_post_commenters_ids.blank?
  end

  # 通知を保存するメソッド
  def save_notification_post_comment!(current_user, post_comment_id, visited_id)
    notification = current_user.active_notifications.build(
      post_id: id,
      post_comment_id: post_comment_id,
      visited_id: visited_id,
      action: 'post_comment'
    )

    # 自分の投稿に対するコメントの場合は、通知済みとする
    notification.is_checked = true if notification.visitor_id == notification.visited_id

    # 通知を保存（バリデーションが成功する場合のみ）
    notification.save if notification.valid?
  end
end
