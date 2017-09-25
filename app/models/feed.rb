class Feed < ActiveRecord::Base

	validates_presence_of :post
  
	
	belongs_to :user
	mount_uploader :image, ImageUploader

	enum status: [:for_all, :only_me, :friends]  

	scope :newest_first, -> {order(created_at: :desc)}

	
	scope :public_and_my_feeds , -> (user_id){where("status = ? or (status = ? and user_id = ?) ", Feed.statuses['for_all'], Feed.statuses['only_me'], user_id)}
 

	
end
