class AddColumnStatusToFriendshipTable < ActiveRecord::Migration
  def change
  	add_column :friendships, :status, :integer , default: 0
  end
end
