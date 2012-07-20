
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
    @bill = Bill.new(params[:bill])
    if @bill.repair_order then
      if @bill.save then
        redirect_to [:admin, @bill.repair_order]
      else
        @repair = @bill.repair_order
        render 'admin/repairs/show'
      end
    else
      redirect_to request.referer, :flash => {:error => "No repair order"}
      return
    end
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
