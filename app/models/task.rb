class Task < ActiveRecord::Base
	has_many :task_statuses, dependent: :destroy
end
