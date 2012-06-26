
class Admin::OwnershipsController < ApplicationController
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
    student = Student.where(:studentid => params[:computer_ownership][:student_id]).first     
    student = Student.find(params[:computer_ownership][:student_id]) if student.nil?
    
    computer = Computer.where(:idtag => params[:computer_ownership][:computer_id]).first
    computer = Computer.find(params[:computer_ownership][:computer_id]) if computer.nil? 
    
    ownership = student.computer_ownerships.new(:computer_id => computer.id, :startdate => Date.parse(params[:date]))
    ownership.save
    
    redirect_to admin_ownership_path(ownership)
  end
  
  def show
    @ownership = ComputerOwnership.find(params[:id])
  end
end
