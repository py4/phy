class ApplicantsController < ApplicationController
	before_action :authenticate_user!

	def show_exam
		@exam_answer = current_user.exam_answers.where(id: params[:exam_answer_id]).first
		return redirect_to profile_path, flash: { error: 'آزمون یافت نشد!' } unless @exam_answer
	end

	def submit_answer
		puts "==========================="
		puts params[:answer]
		puts params[:answer].keys.count
		puts "============================"

		
		exam_answer = current_user.exam_answers.where(id: params[:exam_answer_id]).first
		return redirect_to profile_path, flash: { error: 'آزمون یافت نشد!' } unless exam_answer
		return redirect_to profile_path, flash: { error: 'قبلا به این آزمون پاسخ داده‌اید' } if exam_answer.status

		questions = exam_answer.exam.questions
		special = exam_answer.exam.special

		score = 0
		params[:answer].each do |question_index, choice_index|
			questions[question_index.to_i].answers.create user_id: current_user.id, exam_answer_id: exam_answer.id, choice_index: choice_index.to_i
			splitted = questions[question_index.to_i].mask.split('')
			score += splitted[choice_index.to_i].to_i
		end
		exam_answer.update_attributes status: true, score: score
		return redirect_to profile_path, flash: { success: 'پاسخ‌ها با موفقیت ثبت شدند.' }
	end
end
