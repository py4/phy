class UsersController < ApplicationController
	before_action :authenticate_user!

	def profile
		# if current_user.customer?
		# 	render partial: 'customer_profile'
		# else
		# 	render partial: 'adviser_profile'
		# end
	end
end
