
class Admin::BillsController < ApplicationController
  def new
    @repair = RepairOrder.find(params[:repair_id])
    @bill = @repair.bills.new
  end
  
  def create
    @repair = RepairOrder.find(params[:repair_id])
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
