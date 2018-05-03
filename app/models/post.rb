class Post < ApplicationRecord
  mount_uploader :file_location, PhotoImageUploader
  #belongs_to :category
  has_many :category_of_posts
  belongs_to :privacy
end
