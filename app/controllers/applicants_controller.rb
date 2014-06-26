class ApplicantsController < ApplicationController
	before_action :authenticate_user!

	def show_exam
		@exam_answer = current_user.exam_answers.where(id: params[:exam_answer_id]).first
		return redirect_to profile_path, flash: { error: 'آزمون یافت نشد!' } unless @exam_answer
	end

	def submit_answer
		puts params[:answer]
		puts params[:answer].keys.count
		exam_answer = current_user.exam_answers.where(id: params[:exam_answer_id]).first
		return redirect_to profile_path, flash: { error: 'آزمون یافت نشد!' } unless exam_answer
		return redirect_to profile_path, flash: { error: 'قبلا به این آزمون پاسخ داده‌اید' } if exam_answer.status

		questions = exam_answer.exam.questions
		choices = exam_answer.exam.choices
		special = exam_answer.exam.special

		score = 0
		params[:answer].each do |question_index, choice_index|
			questions[question_index.to_i].answers.create user_id: current_user.id, exam_answer_id: exam_answer.id, choice_index: choice_index.to_i
			if special
				splitted = questions[question_index.to_i].mask.split('-')
				splitted = splitted[(current_user.age.to_i <= splitted[1].to_i) ? 0 : 2].split('')
				score += splitted[choice_index.to_i].to_i
			else
				splitted = questions[question_index.to_i].mask.split('')
				score += splitted[choice_index.to_i].to_i
			end
		end
		exam_answer.update_attributes status: true, score: score
		return redirect_to profile_path, flash: { success: 'پاسخ‌ها با موفقیت ثبت شدند.' }
	end
end
