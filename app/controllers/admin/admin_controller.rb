class Admin::AdminController < ApplicationController
	before_filter :signed_in?
	layout 'admin'

	def index
	end

	def current_admin_user
		@current_user ||= AdminUser.find_by_remember_token(session[:user_token]) if session[:user_token]
		@current_user
	end

	def signed_in?
		!!@current_user
	end

	def signed_out?
		!signed_in?
	end
end