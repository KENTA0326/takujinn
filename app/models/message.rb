class Message < ApplicationRecord
  has_many :notifications, dependent: :destroy
  belongs_to :user
  belongs_to :room
  
  validates :message, presence: true, length: { maximum: 140 }
end
