
class Admin::BillsController < Admin::AdminController
  Messages = {
    :repair_closed => "This repair is closed!"
  }

  def index
    if params[:closed] then
      @bills = Bill.where(:paid => true)
    else
      @bills = Bill.where(:paid => false)
    end

    @closed = params[:closed]
  end
  
  def new
    @repair = RepairOrder.find(params[:repair_id])
    if @repair.open? then
      @bill = @repair.bills.new
    else
      @error = Messages[:repair_closed]
    end
  end
  
  def create
    @repair = RepairOrder.find(params[:repair_order_id])
    if !@repair.open? then
      flash[:error] = Messages[:repair_closed]
      redirect_to edit_admin_repair_order_path(@repair)
      return
    end
    @bill = @repair.bills.new
    @bill.update_attributes(params[:bill])
    
    student = @repair.computer.get_current_student
    @bill.student = student unless student.nil?  
    
    @bill.save
    
    redirect_to [:admin, @repair]
  end

  def destroy
    @bill = Bill.find(params[:id])
    @bill.paid = true
    @bill.save

    redirect_to [:admin, @bill]
  end
  
  def show
    @bill = Bill.find(params[:id])
  end
end
