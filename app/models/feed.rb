class Feed < ActiveRecord::Base

	#validates_presence_of :post
  	#validates_presence_of :image
    has_many :bookmarks
  	validate :at_least_one
	
	belongs_to :user
	mount_uploader :image, ImageUploader

	enum status: [:for_all, :only_me, :friends]  

	scope :newest_first, -> {order(created_at: :desc)}

	
	scope :public_and_my_feeds , -> (user_id){where("status = ? or (status = ? and user_id = ?) ", Feed.statuses['for_all'], Feed.statuses['only_me'], user_id)}
 

#This code is written for validation between post and image, now user can post status or image or both, but cant set blank status

	def at_least_one
	  if [self.post, self.image].reject(&:blank?).size == 0
	    errors[:base] << ("Please choose at least one image or status")
	  end
	end      
	
end
