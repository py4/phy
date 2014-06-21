module ApplicationHelper
	def role_label user
		t("activerecord.attributes.user.user_type_values")[user.user_type]
	end

	def full_name user
		user.name + " " + user.surname
	end
end
