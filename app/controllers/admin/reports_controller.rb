
class Admin::ReportsController < Admin::AdminController

	def index
		if (params[:location]) then
			@location = Location.find(params[:location]);
		end
	end

	def bad
		@list = []
		@report_name = "Bad"
		comp_location.includes(:computer_parts).all.each do |computer|
			@list << computer if computer.bad?
		end
		do_respond
	end

	def good
		@list = []
		@report_name = "Good"
		comp_location.includes(:computer_parts).all.each do |computer|
			@list << computer if computer.good?
		end
		do_respond
	end

	def assigned
		@list = []
		@report_name = "Assigned Computers"
		comp_location.includes(:computer_ownerships).all.each do |computer| 
			@list << computer unless computer.get_current_student.nil?
		end
		do_respond
	end

	def checkout
		@list = []
		@report_name = "Unassigned Checkout Computers"
		comp_location.includes(:computer_ownerships).all.each do |computer| 
			@list << computer if computer.get_current_student.nil?
		end
		do_respond
	end

	def parts
		unless (params[:location].nil?) then
			@location = Location.find(params[:location])
		end
		@parts = []
		ComputerTemplate.all.each do |template|
			template.parts_array.each do |part|
				@parts << part unless @parts.include? part
			end
		end
	end

	def partsview
		@bad = params[:commit] == 'bad'
		@part = params[:part]
		@list = []
		@report_name = location_name((@bad ? "Bad" : "Good") + " " + @part)
		comp_location.includes(:computer_parts).all.each do |computer|
			unless computer.parts[@part].nil? then
				@list << computer if computer.parts[@part].status != @bad
			end
		end
		do_respond
	end

	def fullcsv
		respond_to do |format|
			format.csv { render :csv => Computer.includes(:computer_parts, :computer_ownerships).all,
								:filename => "full_inventory" }
		end
	end

	def comp_location
		unless get_location.nil? then
			return @location.computers
		else
			return Computer
		end
	end

	def get_location
		return @location unless @location.nil?
		unless params[:location].nil? then
			@location = Location.find(params[:location]) 
			return @location
		end
		return nil
	end

	def location_name(name)
		unless get_location.nil? then
			return name + " from #{@location.name}"
		else
			return name
		end
	end

	def do_respond
		respond_to do |format|
			format.html {
				render 'report_view'
			}
			format.csv {
				render :csv => @list, :filename => location_name(@report_name)
			}
		end
	end
end
