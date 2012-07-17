
class Admin::OwnershipsController < Admin::AdminController
  def index
  end
  
  def new
    if !params[:computer_id].nil? then
      computer = Computer.find(params[:computer_id]) 
      @ownership = computer.computer_ownerships.new
      @ownership.student_id = params[:student_id] if !params[:student_id].nil?
    else
      if !params[:student_id].nil? then
        student = Student.find(params[:student_id])
        @ownership = student.computer_ownerships.new
      end
    end
  end
  
  def create
    @students = like_query Student, :studentid, params[:computer_ownership][:student_id]
    @student = @students.first unless @students.length == 0
    @student = Student.find(params[:computer_ownership][:student_id]) if @student.nil?
    
    @computers = like_query Computer, :idtag, params[:computer_ownership][:computer_id]
    @computer = @computers.first unless @computers.length == 0
    @computer = Computer.find(params[:computer_ownership][:computer_id]) if @computer.nil? 

    #TODO check and do flash error if more than one computer
    
    @ownership = @student.computer_ownerships.new(:computer_id => @computer.id, :startdate => Date.parse(params[:date]))
    @ownership.save
    
    redirect_to [:admin, @ownership.student]
  end
  
  def show
    @ownership = ComputerOwnership.find(params[:id])
  end

  def destroy
    @ownership = ComputerOwnership.find(params[:id])
    @ownership.enddate = Date.today
    @ownership.save

    redirect_to request.referer
  end
end
