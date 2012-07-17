class Admin::AdminController < ApplicationController
	before_filter :check_sign_in
	helper_method :signed_in?, :signed_out?, :current_admin_user
	layout 'admin'

	def index
	end

	def current_user
		@current_user ||= AdminUser.find_by_remember_token(session[:user_token]) if session[:user_token]
		@current_user
	end

	def signed_in?
		!!current_user
	end

	def signed_out?
		!signed_in?
	end

	def check_sign_in
		if !signed_in? then
			flash[:info] = "You're not logged in!"
			redirect_to admin_login_path
		end
	end
end