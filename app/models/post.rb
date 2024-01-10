class Post < ApplicationRecord
 validates :user_id, {presence: true}
 belongs_to :user
 has_many :favorites, dependent: :destroy
 
 def favorited_by?(user)
   favorites.exists?(user_id: user.id)
 end 
 
end
