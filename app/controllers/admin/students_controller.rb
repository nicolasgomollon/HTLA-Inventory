
require 'csv'

class Admin::StudentsController < Admin::AdminController
  def index
    query = ""
    query_array = []
    if (params[:fullname]) then
      names = params[:fullname].split(" ")
      if names.length > 0 then
        query = query_helper 'firstname', names[0], query, query_array
        if names.length == 2
          query = query_helper 'lastname', names[1], query, query_array
        else
          query = query_helper 'lastname', names[0], query, query_array
        end
      end
    end
    query = query_helper 'studentid', params[:id], query, query_array
    
    @students = Student.where(query, *query_array) unless query.empty?
    if @students then
      redirect_to [:admin, @students.first] if @students.length == 1
    end
    
    @first = params[:firstname]
    @last = params[:lastname]
    @id = params[:id]
  end
  
  def show
    @student = Student.find(params[:id])
  end

  def import
  end

  def upload
    if params[:csv] then
      csv = CSV.new(params[:csv].read, {:headers => true})
      @count = 0
      csv.each do |row| 
        student = Student.new({
            :firstname => row['First Name'],
            :lastname => row['Last Name'],
            :studentid => row['Student Number']
        })
        if row['Grade Level'] then
          student.classof = Date.today.year + (13 - row['Grade Level'].to_i)
        end
        @count += 1 if student.save
      end
    end
  end

end
