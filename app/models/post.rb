class Post < ApplicationRecord
  mount_uploader :photo, PhotoImageUploader
  has_many :category_of_posts, dependent: :destroy
  belongs_to :privacy
  belongs_to :user
  has_many :replies, dependent: :destroy
end
