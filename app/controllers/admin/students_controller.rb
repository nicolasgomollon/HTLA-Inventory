
class Admin::StudentsController < Admin::AdminController
  def index
    query = ""
    query_array = []
    query = query_helper 'firstname', params[:firstname], query, query_array
    query = query_helper 'lastname', params[:lastname], query, query_array
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
end
