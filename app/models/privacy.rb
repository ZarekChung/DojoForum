class Privacy < ApplicationRecord
  has_many :posts, dependent: :restrict_with_error
end
