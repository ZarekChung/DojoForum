class Post < ApplicationRecord
  mount_uploader :photo, PhotoImageUploader
  validates_presence_of :title
  has_many :category_of_posts, dependent: :destroy
  belongs_to :privacy
  belongs_to :user
  has_many :replies, dependent: :destroy

  has_many :collects, dependent: :destroy
  has_many :collected_users, through: :collects, source: :user

  def is_collected?(user)
    self.collected_users.include?(user)
  end

  def self.filter_by_reviewed_status(user)
  if  user.nil?
      self.where(privacy_id:1)
  else
    if user.friendships.where(:friend_id =>self.select(:user_id))
      self.where(:user_id=>user.friendships.select(:friend_id),privacy_id:[1,2]).or(self.where(user_id:user.id)).or(  self.where(privacy_id:1))
    else
      self.where(privacy_id:1).or(self.where(user_id:user.id))
    end
  end
end
end
