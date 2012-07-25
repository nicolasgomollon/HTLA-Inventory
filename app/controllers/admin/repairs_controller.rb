
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
    @repair = RepairOrder.create(params[:repair_order])
    @activity = @repair.activities.build(params[:activity])
    if @activity.save and @repair.save then
      redirect_to [:admin, @repair]
    else
      @computer = @repair.computer
      render 'admin/computers/show'
    end
  end
  
  def show
    @repair = RepairOrder.find(params[:id])
    @bill = @repair.bills.new
  end
  
  def update
    @repair = RepairOrder.find(params[:id])
    
    @repair.enddate = Date.today if params[:close] == "Close"
    ##TODO association as in #create
    @activity = @repair.activities.new(:date => Date.today, :desc => params[:activity][:desc])
    @activity.message = Activity::Messages[:closed] if params[:close] == "Close"
    
    if @repair.save and @activity.save then
      redirect_to admin_repair_order_path(@repair)
    else
      @bill = @repair.bills.new
      render 'show'
    end
  end
end
