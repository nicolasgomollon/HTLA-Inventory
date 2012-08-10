module Admin::ReportsHelper
	def location_tack(path, location)
		unless location.nil? then
			return path + "?location=#{location.id}"
		else
			return path
		end
	end

	def csv_path(path)
		path.sub(/\?/, ".csv?")
	end

	def this_csv_path
		csv_path(request.url)
	end
end
