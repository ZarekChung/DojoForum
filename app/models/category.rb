class Category < ApplicationRecord
  has_many :category_of_posts, dependent: :restrict_with_error
end
