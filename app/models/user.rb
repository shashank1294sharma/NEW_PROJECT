class User < ActiveRecord::Base

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable, :omniauth_providers => [ :twitter]

  has_many :friend_requests, dependent: :destroy
  has_many :pending_friends, through: :friend_requests, source: :friend

  has_many :friendships, dependent: :destroy
  has_many :friends, through: :friendships

  has_many :feeds
  has_many :bookmarks

  def remove_friend(friend)
    friends.destroy(friend)
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  def is_friend?(user_id)
    friends.pluck(:id).include?(user_id)
  end
end
