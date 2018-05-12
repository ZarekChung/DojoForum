class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  mount_uploader :avatar, AvatarUploader
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :posts,dependent: :destroy
  has_many :replies, dependent: :restrict_with_error

  has_many :collects, dependent: :destroy
  has_many :collected_posts, through: :collects, source: :post
end
