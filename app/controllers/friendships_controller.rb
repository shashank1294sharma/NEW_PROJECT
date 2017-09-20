class FriendshipsController < ApplicationController


	def create
		@friendship = current_user.friendships.build(:friend_id => params[:friend_id])
		if @friendship.save
			flash[:notice] = "Added Friend."
			redirect_to root_url
		else
			flash[:notice] = "Unable to Add Friend."
			redirect_to root_url
		end
	end

	

end
