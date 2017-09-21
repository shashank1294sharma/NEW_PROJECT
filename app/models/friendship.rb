class Friendship < ActiveRecord::Base
	belongs_to :user
	belongs_to :friend, :class_name => 'User'
	enum status: [:pending, :confirmed, :reject]
end
