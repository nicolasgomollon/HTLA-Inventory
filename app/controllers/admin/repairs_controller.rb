
class Admin::RepairsController < Admin::AdminController
  def index
    @closed = !params[:closed].nil?
    @repairs = !@closed ? RepairOrder.where(:enddate => nil) :
      RepairOrder.where(RepairOrder.arel_table[:enddate].not_eq(nil))
  end
  
  def new
    computer = Computer.find(params[:computer_id]) unless params[:computer_id].nil?
    @tag = computer.idtag unless computer.nil?
    @repair = RepairOrder.new
  end
  
  def create
    @repair = RepairOrder.new
    @repair.update_attributes(params[:repair_order])
    ## TODO, associate activity with the logged in student (ancillary, logins...)
    @activity = @repair.activities.new(:desc => params[:desc], :date => Date.today, :message => Activity::Messages[:created])
    
    @repair.save
    @activity.save
    
    redirect_to admin_repair_order_path(@repair)
  end
  
  def show
    @repair = RepairOrder.find(params[:id])
    @bill = @repair.bills.new
  end
  
  def update
    repair = RepairOrder.find(params[:id])
    
    repair.enddate = Date.today if params[:close]
    ##TODO association as in #create
    activity = repair.activities.new(:date => Date.today, :desc => params[:desc])
    activity.message = Activity::Messages[:closed] if params[:close]
    
    repair.save
    activity.save
    
    redirect_to admin_repair_order_path(repair)
  end
end
