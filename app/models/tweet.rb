class Tweet < ApplicationRecord
  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_one_attached :image
  
  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end
end
