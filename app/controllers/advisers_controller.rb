class AdvisersController < ApplicationController
	def search_applicant
		@applicant = User.where(user_code: params[:user_code]).first
		render layout: false
	end

	def add_applicant
		applicant = User.where(user_code: params[:user_code]).first
		if applicant
			applicant.update_attributes adviser: current_user
			redirect_to profile_path, flash: { success: "متقاضی با موفقیت اضافه شد!"}
		else
			redirect_to profile_path, flash: { error: "متقاضی یافت نشد!" }
		end
	end

	def remove_advisership
		puts params
		applicant = current_user.applicants.where(id: params[:applicant_id]).first
		if applicant
			applicant.update_attributes adviser_id: nil
			redirect_to profile_path, flash: { success: 'مسئولیت با موفقیت حذف شد!' }
		else
			redirect_to profile_path, flash: { error: 'متقاضی یافت نشد!' }
		end
	end

	def show_applicant
		@applicant = current_user.applicants.where(id: params[:applicant_id]).first
		return redirect_to profile_path, flash: { error: 'متقاضی یافت نشد!' } unless @applicant
	end

	def update_status
		applicant = current_user.applicants.where(id: params[:applicant_id]).first
		return redirect_to profile_path, flash: { error: 'متقاضی یافت نشد!' } unless applicant
		if applicant.update_attributes status: params[:status][:status]
			redirect_to show_applicant_path(applicant), flash: { success: 'وضعیت کلی متقاضی به روز شد' }
		else
			redirect_to show_applicant_path(applicant), flash: { error: 'خطا.' }
		end
	end

	def update_task_status
		applicant = current_user.applicants.where(id: params[:applicant_id]).first
		return redirect_to profile_path, flash: { error: 'متقاضی یافت نشد!' } unless applicant
		task_status = applicant.task_statuses.where(id: params[:task_status_id]).first
		return redirect_to profile_path, flash: { error: 'تسک یافت نشد!' } unless task_status
		if task_status.value
			unless task_status.update_attributes value: false
				return redirect_to show_applicant_path(applicant), flash: { error: 'خطا.' }
			end
		else
			unless task_status.update_attributes value: true
				return redirect_to show_applicant_path(applicant), flash: { error: 'خطا.' }
			end
		end

		return redirect_to show_applicant_path(applicant)
	end
end
