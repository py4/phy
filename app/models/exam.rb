class Exam < ActiveRecord::Base
	store_accessor :subject
	has_many :exam_answers, dependent: :destroy
	has_many :questions, dependent: :destroy
end
