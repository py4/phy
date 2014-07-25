class Exam < ActiveRecord::Base
	has_many :exam_answers, dependent: :destroy
	has_many :questions, dependent: :destroy
	#has_many :choices, dependent: :destroy
end
