class User < ActiveRecord::Base
  #Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable

  # validates :friend, presence: true

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :feeds 


  #friends
  has_many :friendships
  has_many :friends, :through => :friendships


  #in-terms of friendships
  # has_many :friendships , dependent: :destroy
  # has_many :friends, :through => :friendships

  # #in-terms of friend_request
  # has_many :friend_requests, dependent: :destroy
  # has_many :pending_friends, through: :friend_requests, source: :friend

  # def remove_friend(friend)
  # 	current_user.friends.destroy(friend)
  # end
  
end
