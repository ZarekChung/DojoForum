class Post < ApplicationRecord
  mount_uploader :file_location, PhotoImageUploader  
end
