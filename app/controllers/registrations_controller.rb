class RegistrationsController < Devise::RegistrationsController

	def create
		build_resource(sign_up_params)

		resource_saved = resource.save
		yield resource if block_given?
		if resource_saved
			if resource.active_for_authentication?
				set_flash_message :notice, :signed_up if is_flashing_format?
				sign_up(resource_name, resource)
				#respond_with resource, location: after_sign_up_path_for(resource)
				if resource.user_type == 1
					return redirect_to profile_path#, flash: { success: 'با موفقیت عضو شدید.' }
				else
					return redirect_to profile_path, flash: { success: "کد کاربری شما #{resource.user_code} است. آن را به مشاور بدهید."}
				end				
			else
				set_flash_message :notice, :"signed_up_but_#{resource.inactive_message}" if is_flashing_format?
				expire_data_after_sign_in!
				respond_with resource, location: after_inactive_sign_up_path_for(resource)
			end
		else
			clean_up_passwords resource
			respond_with resource
		end
	end

	private

	def sign_up_params
		params.require(:user).permit(:name, :surname, :email, :password, :password_confirmation, :age, :user_type, :username)
	end

	def account_update_params
		params.require(:user).permit(:name, :surname, :email, :password, :password_confirmation, :age, :user_type, :username)
	end
end