class FacebooksController < ApplicationController
	def facebook_profile
	
	    token = "EAACEdEose0cBAD6BZA5D2DcNtgPEsLw2q6NWHe9FB6xloiY259SoWU6WGZAEht2JN003tB7KxhnQ6RgPm24EATUJXxzIVLscIcBT5eKEyOyfYB8CYoWxIulIuLidtTTRPdRstzn02bxa2STzk1HVIqZCtZCjAP4TazYJOgjHbum7k2yZBGTPvtscjuuAeQ78JUeGluLP5uAZDZD"
		@graph = Koala::Facebook::API.new(current_user.token,Rails.application.secrets.facebook_secret_id)
		@profile = @graph.get_object("me")
		if current_user.email != "shashankssharma1294@gmail.com"
			@friends = @graph.get_connections("me", "friends",api_version: "v2.10")
		else
			@friends = @graph.get_connections("me", "friends",api_version: "v2.10")
		end
	end
end
