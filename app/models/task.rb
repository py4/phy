class Task < ActiveRecord::Base
	has_many :task_statuses
end
