class ChangeDefualt < ActiveRecord::Migration
  def change
 		change_column :users, :type, :integer, default: 0
  end
end
