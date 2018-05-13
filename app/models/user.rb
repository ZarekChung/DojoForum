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

  #friendship
  has_many :friendships, dependent: :destroy
  has_many :friend, -> { where('is_confirm = ?', true) }, through: :friendships

  #新增一組user to firend_id的foreign_key
  has_many :inverse_friends, -> { where('is_confirm = ?', false) },class_name: "Friendship", foreign_key: "friend_id"
  has_many :friended, -> { where('is_confirm = ?', true) },through: :inverse_friends, source: :user

  before_create :generate_authentication_token

  def generate_authentication_token
    self.authentication_token = Devise.friendly_token
  end

  def admin?
   self.role == "admin"
  end

  def is_firend?(user)
   self.friend.include?(user)
 end

 def is_wait?(user)
  self.friendships.where(:friend_id => user.id).blank?
 end

 def all_friends
    (self.friend + self.friended).uniq
  end

end
