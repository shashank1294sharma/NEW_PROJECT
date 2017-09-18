class AddEnumFieldsToFeedsTable < ActiveRecord::Migration
  def change
  	 add_column :feeds, :status, :integer, default: 0
  end
end
