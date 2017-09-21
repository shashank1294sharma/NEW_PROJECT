class UsersController < ApplicationController

 

  def index
    @users = User.all
  end

  def add_friend
    
  end

  def remove_friend
    
  end

  def show
   
    @friendship = Friendship.new
    @user = User.find(params[:id])
  end

  def find_friends
    @users = User.all
  end

  def about_me
    @user = User.find(params[:id])
  end

  def moveToTimeline
  end

end
