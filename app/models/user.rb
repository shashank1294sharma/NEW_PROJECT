class User < ActiveRecord::Base

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :friend_requests, dependent: :destroy
  has_many :pending_friends, through: :friend_requests, source: :friend

  has_many :friendships, dependent: :destroy
  has_many :friends, through: :friendships

  has_many :feeds
  has_many :bookmarks

  devise :omniauthable, :omniauth_providers => [:facebook]

  def remove_friend(friend)
    friends.destroy(friend)
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  def is_friend?(user)
    friends.pluck(:id).include?(user.id)
  end

  def has_incoming_request_from?(user)
    FriendRequest.where(friend: self, user_id: user.id).present?
  end

  def has_sent_friend_request?(user)
    self.pending_friends.where(id: user.id).present?
  end

  def friend_request_for(user)
    self.friend_requests.where(friend_id: user.id).last
  end


  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
    user.email = auth.info.email
    user.password = Devise.friendly_token[0,20]
    user.name = auth.info.name   # assuming the user model has a name
    #user.image = auth.info.image # assuming the user model has an image
    # If you are using confirmable and the provider(s) you use validate emails, 
    # uncomment the line below to skip the confirmation emails.
    # user.skip_confirmation!
  end
end

 def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end
  
end
