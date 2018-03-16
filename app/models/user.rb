class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  
  has_many :tweets

  mount_uploader :avatar, AvatarUploader

  validates :username, presence: true, uniqueness: true

  serialize :following, Array

  def count_followers
    
    followers = 0

    User.all.each do |user|
      if user.following.include?(self.id)
        followers += 1
      end
    end
    return followers
  end

end
