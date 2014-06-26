class Answer < ActiveRecord::Base
  belongs_to :question
  belongs_to :user
  belongs_to :exam_answer
end
