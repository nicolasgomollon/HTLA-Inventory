
class Admin::ReportsController < Admin::AdminController

	def index
		if (params[:location]) then
			@location = Location.find(params[:location]);
		end
	end

	def bad
		@bad = []
		comp_location.includes(:computer_parts).all.each do |computer|
			@bad << computer if computer.bad?
		end
		respond_to do |format|
			format.html
			format.csv {
				render :csv => @bad, :filename => location_name("Bad")
			}
		end
	end

	def good
		@good = []
		comp_location.includes(:computer_parts).all.each do |computer|
			@good << computer if computer.good?
		end
		respond_to do |format|
			format.html
			format.csv {
				render :csv => @good, :filename => location_name("Good")
			}
		end
	end

	def assigned
		@assigned = []
		comp_location.includes(:computer_ownerships).all.each do |computer| 
			@assigned << computer unless computer.get_current_student.nil?
		end
		respond_to do |format|
			format.html
			format.csv {
				render :csv => @assigned, :filename => location_name("Assigned Computers")
			}
		end
	end

	def checkout
		@checkout = []
		comp_location.includes(:computer_ownerships).all.each do |computer| 
			@checkout << computer if computer.get_current_student.nil?
		end
		respond_to do |format|
			format.html
			format.csv {
				render :csv => @checkout, :filename => location_name("Checkout Computers")
			}
		end
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
		comp_location.includes(:computer_parts).all.each do |computer|
			unless computer.parts[@part].nil? then
				@list << computer if computer.parts[@part].status != @bad
			end
		end
		respond_to do |format|
			format.html
			format.csv {
				render :csv => @list, :filename => location_name((@bad ? "Bad" : "Good") + " " + @part)
			}
		end
	end

	def fullcsv
		respond_to do |format|
			format.csv { render :csv => Computer.includes(:computer_parts, :computer_ownerships).all,
								:filename => "full_inventory" }
		end
	end

	def comp_location
		unless params[:location].nil? then
			return Location.find(params[:location]).computers
		else
			return Computer
		end
	end

	def location_name(name)
		unless @location.nil? then
			return name + " from #{@location.name}"
		else
			return name
		end
	end
end
