class Report < ApplicationRecord
  belongs_to :reporter, class_name: "User"
  belongs_to :reported, class_name: "User"

  # reporter_idがuser_idである通報の件数を返すクラスメソッド(ここを追記)
  def self.reported_count(user_id)
    where(reported_id: user_id).count
  end
  validates :reason, presence: true
end
