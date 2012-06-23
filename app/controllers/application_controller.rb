class ApplicationController < ActionController::Base
  protect_from_forgery
  
  def query_helper name, value, query_string, query_array
    if !value.nil? then
      if !value.empty? then
        query_string += " OR " unless query_string.empty?
        query_string += "#{name} LIKE ?"
        query_array.push("%#{value}%")
      end
    end
    query_string
  end
end
