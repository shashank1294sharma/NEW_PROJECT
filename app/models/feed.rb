class Feed < ActiveRecord::Base
	belongs_to :user

	enum status: [:for_all, :only_me, :friends]  

	scope :newest_first, -> {order(created_at: :desc)}

	scope :public_feeds , -> {where(status: 'for_all')}
	scope :public_and_my_feeds , -> (user_id){where("status = ? or (status = ? and user_id = ?) ", Feed.statuses['for_all'], Feed.statuses['only_me'], user_id)}
	
end
