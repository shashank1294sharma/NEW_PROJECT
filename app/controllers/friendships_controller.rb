class FriendshipsController < ApplicationController
 

  def create
    binding.pry
    @friendship = current_user.friendships.build(:friend_id => params[:friend_id])
   
    if @friendship.save
      flash[:notice] = "Added friend"
      redirect_to root_url
    else
      flash[:notice] = "unable to Add Friend"
      redirect_to root_url
    end
  end

  def accept_request
    binding.pry
    inverse_friendship = current_user.inverse_friendships.build(:friend_id => params[:friend_id])
    inverse_friendship.save
  end

  def destroy
    @friendship = current_user.friendships.find(params[:id])
    @friendship.destroy
    flash[:notice] = "Removed friendship."
    redirect_to current_user
  end

  def index
    # @sent_requests = current_user.inverse_friends
    # @added_friends = @friendship.id
    @friends = current_user.friends #.inverse_friends
  end

  def friend_requests
    # @sent_requests = current_user.inverse_friends
    # @added_friends = @friendship.id
    @friend_requests = current_user.friend_requests
  end
 
end
