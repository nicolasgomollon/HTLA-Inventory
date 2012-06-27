
class Admin::BillsController < ApplicationController
  Messages = {
    :repair_closed => "This repair is closed!"
  }
  
  def new
    @repair = RepairOrder.find(params[:repair_id])
    if @repair.open? then
      @bill = @repair.bills.new
    else
      @error = Messages[:repair_closed]
    end
  end
  
  def create
    @repair = RepairOrder.find(params[:repair_id])
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
    
    redirect_to [:admin, @bill]
  end
  
  def show
    @bill = Bill.find(params[:id])
  end
end
