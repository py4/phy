class AddValueToTaskStatuses < ActiveRecord::Migration
  def change
    add_column :task_statuses, :value, :boolean
  end
end
