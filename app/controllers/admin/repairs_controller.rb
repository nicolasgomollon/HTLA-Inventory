
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
    computer = Computer.where(:idtag => params[:computer_tag]).first
    @repair = computer.repair_orders.new(:startdate => Date.parse(params[:date]))
    ## TODO, associate activity with the logged in student (ancillary, logins...)
    @activity = @repair.activities.new(:desc => params[:desc], :date => Date.today, :message => Activity::Messages[:created])
    
    @repair.save
    @activity.save
    
    redirect_to admin_repair_order_path(@repair)
  end
  
  def show
    @repair = RepairOrder.find(params[:id])
  end
  
  def edit
    @repair = RepairOrder.find(params[:id])
    
    redirect_to admin_repair_order_path(@repair) unless @repair.enddate.nil?
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
