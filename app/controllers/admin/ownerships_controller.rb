
class Admin::OwnershipsController < ApplicationController
  def index
  end
  
  def new
    @mode = ""
    if !params[:studentid].nil?
      @mode = "computer"
      @student = Student.where(:studentid => params[:studentid]).first
      @computers = Computer.all
    elsif !params[:computertag].nil?  
      @mode = "student"
      @computertag = params[:computertag]
      @students = Student.all
    else  
      @mode = "neither"
    end
  end
  
  def create
    student = Student.find(params[:studentid])
    
    student.computer_ownerships.create(:startdate => Date.today, :computer_id => params[:computerid])
  end
  
  def show
    @ownership = ComputerOwnership.find(params[:id])
  end
end
