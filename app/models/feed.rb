class Feed < ActiveRecord::Base
	belongs_to :users

	enum status: [:for_all, :only_me, :friends]  
end
