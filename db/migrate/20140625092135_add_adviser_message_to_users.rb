class AddAdviserMessageToUsers < ActiveRecord::Migration
  def change
    add_column :users, :adviser_message, :string
  end
end
