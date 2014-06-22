class UsersController < ApplicationController
	before_action :authenticate_user!

	def profile
	end

	def search_customer
		@customer = User.where(user_code: params[:user_code]).first
		render layout: false
	end

	def add_customer
		@customer = User.where(user_code: params[:user_code]).first
		if @customer
			@customer.update_attributes adviser: current_user
			redirect_to profile_path, flash: { success: "متقاضی با موفقیت اضافه شد!"}
		else
			redirect_to profile_path, flash: { error: "متقاضی یافت نشد!" }
		end
	end

	def remove_advisership
		puts params
		@customer = current_user.customers.where(id: params[:customer_id]).first
		if @customer
			@customer.update_attributes adviser_id: nil
			redirect_to profile_path, flash: { success: 'مسئولیت با موفقیت حذف شد!' }
		else
			redirect_to profile_path, flash: { error: 'متقاضی یافت نشد!' }
		end
	end

	def show_customer
	end
end
