class FacebooksController < ApplicationController
	
	def facebook_profile
		@graph = Koala::Facebook::API.new(current_user.token,"b2b271db6861f8c7271a8ba5bbde9a13")
		@profile = @graph.get_object("me")
		#@friends = @graph.get_connections("me", "taggable_friends",api_version: "v2.10")
		
		if current_user.email != "shashankssharma1294@gmail.com"
			@friends = @graph.get_connections("me", "taggable_friends",api_version: "v2.10")
		else
			@friends = @graph.get_connections("me", "friends",api_version: "v2.10")
		end
	end
end
