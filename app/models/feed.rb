class Feed < ActiveRecord::Base
	belongs_to :users 

	enum status: [:for_all, :only_me, :friends]  

	scope :newest_first, -> {order(created_at: :desc)}
end
