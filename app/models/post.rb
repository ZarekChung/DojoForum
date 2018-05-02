class Post < ApplicationRecord
  mount_uploader :file_location, PhotoImageUploader
  belongs_to :category
end
