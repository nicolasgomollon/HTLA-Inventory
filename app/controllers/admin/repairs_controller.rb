
class Admin::RepairsController < ApplicationController
  def new
    computer = Computer.find(params[:computer_id]) unless params[:computer_id].nil?
    @tag = computer.idtag unless computer.nil?
    @repair = RepairOrder.new
  end
  
  def create
    computer = Computer.where(:idtag => params[:computer_tag]).first
    repair = computer.repair_orders.new(:startdate => Date.parse(params[:date]))
    ## TODO, associate activity with the logged in student (ancillary, logins...)
    activity = repair.activities.new(:desc => params[:desc], :date => Date.today, :message => Activity::Messages[:created])
    
    repair.save
    activity.save
    
    redirect_to admin_repair_order_path(repair)
  end
  
  def show
    @repair = RepairOrder.find(params[:id])
  end
end
