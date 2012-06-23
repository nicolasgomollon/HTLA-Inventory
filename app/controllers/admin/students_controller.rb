
class Admin::StudentsController < ApplicationController
  def index
    query = ""
    query_array = []
    query = query_helper 'firstname', params[:firstname], query, query_array
    query = query_helper 'lastname', params[:lastname], query, query_array
    query = query_helper 'studentid', params[:id], query, query_array
    
    @students = Student.where(query, *query_array) unless query.empty?
    
    @first = params[:firstname]
    @last = params[:lastname]
    @id = params[:id]
  end
  
  def query_helper name, value, query_string, query_array
    if !value.nil? then
      if !value.empty? then
        query_string += " OR " unless query_string.empty?
        query_string += "#{name} LIKE ?"
        query_array.push(value)
      end
    end
    query_string
  end
  
  def show
    @student = Student.find(params[:id])
  end
end
