class UsersController < ApplicationController

  def index
    @users = User.all
  end

  def show
    @friendship = Friendship.new
    @user = User.find(params[:id])
  end

  def find_friends
    # binding.pry
    @users = User.all.reject{|u| u.id == current_user.id}
    # @friendships = current_user.friendships
  end

  def add_friend
    
  end
  
  def remove_friend
    
  end

  # def about_me
  #   @user = User.find(params[:id])
  # end

  # def moveToTimeline
  # end

end
