class Post < ApplicationRecord
  mount_uploader :photo, PhotoImageUploader
  has_many :category_of_posts
  belongs_to :privacy
end
