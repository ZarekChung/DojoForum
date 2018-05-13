class Post < ApplicationRecord
  mount_uploader :photo, PhotoImageUploader
  validates_presence_of :title
  has_many :category_of_posts, dependent: :destroy
  belongs_to :privacy
  belongs_to :user
  has_many :replies, dependent: :destroy

  has_many :collects, dependent: :destroy
  has_many :collected_users, through: :collects, source: :user

  def is_collected?(user)
    self.collected_users.include?(user)
  end

  #def is_public?(user)
    #self.privacy ==Privacy.first
  #end

  def is_friendOnly?(user)
    self.user == user || self.user.is_firend?(user)
  end

  def is_private?(user)
    self.user == user
  end




end
