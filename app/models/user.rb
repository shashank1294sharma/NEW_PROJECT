class User < ActiveRecord::Base

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  attr_accessor :skip_email_validations

  has_many :friend_requests, dependent: :destroy
  has_many :pending_friends, through: :friend_requests, source: :friend

  has_many :friendships, dependent: :destroy
  has_many :friends, through: :friendships

  has_many :feeds, dependent: :destroy
  has_many :bookmarks

  devise :omniauthable, :omniauth_providers => [:facebook , :twitter , :google_oauth2]

  # validates :provider, allow_nil: false 

  validates :email, uniqueness: false, if: :skip_email_validations

  # validates :provider, acceptance: true, allow_nil: false, on: :create


  # validates_presence_of :password_confirmation, :if => :should_confirm?

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
    # user.name = auth.info.name   # assuming the user model has a name
    #user.image = auth.info.image # assuming the user model has an image
    # If you are using confirmable and the provider(s) you use validate emails, 
    # uncomment the line below to skip the confirmation emails.
    # user.skip_confirmation!
  end

 #  def self.from_omniauth_twitter(auth)

 #    user = where(provider: auth['provider'], uid: auth['uid']).first
 #    if user.present?
 #      user
 #    else
 #      user = User.new
 #      user.name = auth['name']
 #      user.email = auth['email']
 #      user.save

 #    end
    
 #    user
 #  end

  end

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end

  def self.with_search(term, user)
    self.order(:email).where("email like ?", "#{term}%").reject{|u| u.is_friend?(user) || u.has_incoming_request_from?(user) || u.has_sent_friend_request?(user) || u.id == user.id}
  end
end
