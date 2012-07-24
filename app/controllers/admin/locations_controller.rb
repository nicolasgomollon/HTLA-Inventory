
class Admin::LocationsController < Admin::AdminController
	def index
		@locations = Location.all
	end

	def new
		@location = Location.new
	end

	def create
		@location = Location.new(params[:location])
		if @location.save then
			redirect_to [:admin, @location]
		else
			render 'new'
		end
	end

	def update
		@location = Location.find(params[:id])
		if @location.update_attributes(params[:location]) then
			redirect_to [:admin, location]
		else
			render 'edit'
		end
	end

	def show
		@location = Location.find(params[:id])
	end
end
