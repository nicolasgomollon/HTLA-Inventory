
class Admin::ReportsController < Admin::AdminController

	def index
	end

	def bad
		@bad = []
		Computer.includes(:computer_parts).all.each do |computer|
			@bad << computer if computer.bad?
		end
	end

	def good
		@good = []
		Computer.includes(:computer_parts).all.each do |computer|
			@good << computer if computer.good?
		end
	end

	def parts
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
		Computer.includes(:computer_parts).all.each do |computer|
			unless computer.parts[@part].nil? then
				@list << computer if computer.parts[@part].status != @bad
			end
		end
	end

	def fullcsv
		respond_to do |format|
			format.csv { render :csv => Computer.includes(:computer_parts, :computer_ownerships).all,
								:filename => "full_inventory" }
		end
	end
end
