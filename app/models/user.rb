class User < ActiveRecord::Base
  #Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable

  # validates :friend, presence: true
  #validate :check_user

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable, :omniauth_providers => [ :twitter]

  has_many :feeds
  has_many :bookmarks

  #friends
  has_many :friendships
  has_many :friends, through: :friendships , source: :friend

#for reverse (inverse friendship)
  has_many :inverse_friendships , :class_name => "Friendship", :foreign_key => "friend_id"
  has_many :inverse_friends , :through => :inverse_friendships , source: :user

 # validate :check_user
 #  def check_user
 #    if self.friend_id == self.user_id
 #      errors.add(:friend, "can't be yourself")
 #    end
 # end

  #in-terms of friendships
  # has_many :friendships , dependent: :destroy
  # has_many :friends, :through => :friendships

  # #in-terms of friend_request
  # has_many :friend_requests, dependent: :destroy
  # has_many :pending_friends, through: :friend_requests, source: :friend

  # def remove_friend(friend)
  # 	current_user.friends.destroy(friend)
  # end

  def friend_requests
    # binding.pry
    self.inverse_friends #.friends.reject{|u| u.inverse_friends}
  end
end