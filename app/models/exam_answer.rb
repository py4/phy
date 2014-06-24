class ExamAnswer < ActiveRecord::Base
  belongs_to :exam
  belongs_to :user
end
