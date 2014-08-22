class ApplicantsController < ApplicationController
	before_action :authenticate_user!

	def show_exam
		@exam_answer = current_user.exam_answers.where(id: params[:exam_answer_id]).first
		return redirect_to profile_path, flash: { error: 'آزمون یافت نشد!' } unless @exam_answer
	end

	def submit_answer
		exam_answer = current_user.exam_answers.where(id: params[:exam_answer_id]).first
		return redirect_to profile_path, flash: { error: 'آزمون یافت نشد!' } unless exam_answer
		return redirect_to profile_path, flash: { error: 'قبلا به این آزمون پاسخ داده‌اید' } if exam_answer.status

		if exam_answer.exam.name == 'آزمون هالند'
			handle_holand exam_answer
			return redirect_to profile_path, flash: { success: 'پاسخ‌ها با موفقیت ثبت شدند.' }
		end

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

	private
	def handle_holand exam_answer
		h = {}
		temp = {}
		params[:answer].keys.each do |main_key|
			splitted = main_key.split('-')
			key, q_id, sq_id, ssq_id = splitted[0], splitted[1], splitted[2], splitted[3]
			h[key] ||= {}
			h[key][q_id] ||= {}
			if key == 't1'
				h[key][q_id][sq_id] ||= {}
				h[key][q_id][sq_id][ssq_id] = params[:answer][main_key].to_i
			else 
				h[key][q_id][sq_id] = params[:answer][main_key]
			end
		end

		puts "h: #{h}"
		keys = ['و', 'ا', 'ج', 'م', 'ه', 'ق']
		result = {}
		keys.each_with_index do |key, i|
			score = 0
			h["t1"].each do |main_q_index, sq|
				sq[i.to_s].each do |j, v|
					score += v
				end
			end

			score += h["t2"]["0"][i.to_s].to_i
			score += h["t2"]["1"][i.to_s].to_i
			result[key] = score
		end

		exam_answer.scores = result
		exam_answer.status = true
		exam_answer.save!

		puts "result: #{result}"
	end
end
