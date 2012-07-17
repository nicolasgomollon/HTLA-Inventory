
class Admin::UsersController < Admin::AdminController
	def index
		@users = AdminUser.all
	end

	def edit
		@user = AdminUser.find(params[:id])
	end

	def update
		@user = AdminUser.find(params[:id])
		if @user.update_attributes(params[:admin_user]) then
			redirect_to admin_admin_users_path, :flash => {:success => "#{@user.username}'s account updated"}
		else
			render 'edit'
		end
	end

	def show
		@user = AdminUser.find(params[:id])
	end
end
