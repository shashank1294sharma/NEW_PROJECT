class FeedsController < ApplicationController
before_action :set_feed , only: [:edit,:update,:show,:destroy]


  def index
    @feeds = current_user.feeds
    # @posts = Feed.ids(params[:id]).order("created_at DESC")
  end

  def new
    @users = User.all
    @feed = Feed.new
    @feeds =  if  current_user.present?
      Feed.public_and_my_feeds(current_user.id).newest_first
    else
      Feed.for_all.newest_first
    end
  end

  def create
    @feed = current_user.feeds.build(feed_params)
     @feeds =  if  current_user.present?
      Feed.public_and_my_feeds(current_user.id).newest_first
    else
      Feed.for_all.newest_first
    end
    if @feed.save
      flash[:success] = "Feed was succesfully created"
      redirect_to new_feed_path
    else
      render 'new'
    end
  end

  def update

    if @feed.update(feed_params)
      
      flash[:success] = "Feed Succesfully Updated"
      redirect_to feed_path(@feed)
    else
      render 'edit'
    end
  end

  def destroy
    # @feed.destroy
    # flash[:danger] = "Feed Deleted Succesfully"
    # redirect_to feed_path


        if @feed.present?
          @feed.destroy 
        end
        redirect_to new_feed_path
  end

  def show
    
    redirect_to new_feed_path
  end

  def edit
    @users = User.all
    @feeds =  if  current_user.present?
        Feed.public_and_my_feeds(current_user.id).newest_first
      else
        Feed.public_feeds.newest_first
      end
    
  end
  



  private

  def set_feed
    @feed = current_user.feeds.find(params[:id])
    end

  def feed_params
    params.require(:feed).permit(:post,:status)
  end
end
