class RegistrationsController < Devise::RegistrationsController

	private

	def sign_up_params
		params.require(:user).permit(:name, :surname, :email, :password, :password_confirmation, :age, :user_type, :username)
	end

	def account_update_params
		params.require(:user).permit(:name, :surname, :email, :password, :password_confirmation, :age, :user_type, :username)
	end
end