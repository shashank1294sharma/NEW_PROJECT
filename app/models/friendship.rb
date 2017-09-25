class Friendship < ActiveRecord::Base
  validate :not_self

  after_create :create_inverse_relationship
  after_destroy :destroy_inverse_relationship

  belongs_to :user
  belongs_to :friend, :class_name => 'User'
  enum status: [:pending, :confirmed, :reject]

  private

  def not_self
    errors.add(:friend, "can't be equal to user") if user == friend
  end

  def create_inverse_relationship
    friend.friendships.create(friend: user)
  end

  def destroy_inverse_relationship
    friendship = friend.friendships.find_by(friend: user)
    friendship.destroy if friendship
    end
  end

