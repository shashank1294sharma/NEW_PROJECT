class UsersController < ApplicationController

  before_action :authenticate_user!

  def index
    @users = User.all
  end

  def add_friend
    
  end

  def remove_friend
    
  end

  def show

    @user = User.find(params[:id])
  end

  def find_friends
    @users = User.all
  end

  def moveToTimeline
  end

end
