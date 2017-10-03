class BookmarksController < ApplicationController

  def create
    bookmark = current_user.bookmarks.new(feed_id: params[:feed_id])
    if bookmark.save
      redirect_to bookmarks_path
    else
      redirect_to :back
    end
  end

  def index
    @bookmarks = current_user.bookmarks
  end
end
