class AddAdviserIdToUsers < ActiveRecord::Migration
  def change
    add_column :users, :adviser_id, :integer
  end
end
