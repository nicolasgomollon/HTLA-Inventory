
class Admin::OwnershipsController < ApplicationController
  def index
  end
  
  def new
    @sid = params[:sid]
    @cid = params[:cid]
  end
  
  def create
    student = Student.find(params[:studentid])
    
    student.computer_ownerships.create(:startdate => Date.today, :computer_id => params[:computerid])
  end
  
  def show
    @ownership = ComputerOwnership.find(params[:id])
  end
end
