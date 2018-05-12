class Post < ApplicationRecord
  mount_uploader :photo, PhotoImageUploader
  has_many :category_of_posts, dependent: :destroy
  belongs_to :privacy
  belongs_to :user
  has_many :replies, dependent: :destroy

  has_many :collects, dependent: :destroy
  has_many :collected_users, through: :collects, source: :user

  def is_collected?(user)
    self.collected_users.include?(user)
  end
end
