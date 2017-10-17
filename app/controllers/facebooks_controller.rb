class FacebooksController < ApplicationController
	def facebook_profile
	
	    oauth_token = "EAACEdEose0cBALjSgJWI9ejkmda6nc5XpjvHLEgH0qTNuNM0LcxbWtNFEWZAmj5jD6ZCEAvV9nQoqsMXQfYxJTUKxtzL1L2VWdoWiCdA8ALKTiyMhjE0fCNjYAiVBJ5O2iWmRZCGRLLpOoYOYTV7QAptyF0ZCF13yJQqjEAABl6jZAu2Ndf5pMVZAhZBsfFpL8ZD"
		@graph = Koala::Facebook::API.new(current_user.oauth_token,Rails.application.secrets.facebook_secret_id)
		@profile = @graph.get_object("me")
		if current_user.email != "shashankssharma1294@gmail.com"
			@friends = @graph.get_connections("me", "friends",api_version: "v2.10")
		else
			@friends = @graph.get_connections("me", "friends",api_version: "v2.10")
		end
	end
end
