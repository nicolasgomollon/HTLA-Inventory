
class Admin::OwnershipsController < Admin::AdminController
  def index
  end
  
  def new
    if !params[:student_id].nil? then
      student = Student.find(params[:student_id])
      @ownership = student.computer_ownerships.new
    end
  end
  
  def create
    @ownership = ComputerOwnership.new(params[:computer_ownership])
    if @ownership.save then
      redirect_to [:admin, @ownership.student]
    else
      render 'new'
    end
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
