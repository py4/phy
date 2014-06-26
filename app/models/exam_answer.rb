class ExamAnswer < ActiveRecord::Base
  belongs_to :exam
  belongs_to :user
  has_many :answers, dependent: :destroy
end
