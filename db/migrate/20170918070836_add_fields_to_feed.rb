class AddFieldsToFeed < ActiveRecord::Migration
  def change
  	add_column :feeds , :user_id, :integer
  	add_column :feeds , :post, :string
  	add_column :feeds , :image, :string
  end
end
