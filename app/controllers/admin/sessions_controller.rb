
class Admin::SessionsController < Admin::AdminController	
	skip_before_filter :signed_in?, :only => [:create]

	def new
	end

	def create
	end

	def destroy
	end
end
