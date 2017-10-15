class UsersController < ApplicationController

  def index
    @users = User.all
  end

  def show
    @friendship = Friendship.new
    @user = User.find(params[:id])
  end

  def find_friends
    @users = User.all.reject{|u| u.id == current_user.id}
  end

  def add_friend
    
  end
  
  def remove_friend
    
  end

  def email_search
    @users = User.with_search(params[:term], current_user)
    render json: @users.map(&:email)
  end
end
