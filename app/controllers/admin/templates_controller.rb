
class Admin::TemplatesController < Admin::AdminController
  def new
    @template = ComputerTemplate.new
  end
  
  def create
    if params[:commit] == "add" then
      @template = ComputerTemplate.new(params[:computer_template])
      @template.parts_array = @template.parts_array << "New Part"
      render 'new'
    else
      @template = ComputerTemplate.new(params[:computer_template])
      if @template.save then
        redirect_to [:admin, @template]
      else
        render 'new'
      end
    end
  end

  def update
    @template = ComputerTemplate.find(params[:id])
    if params[:commit] == "add" then
      @template.parts_array = params[:computer_template][:parts_array]
      @template.parts_array = @template.parts_array << "New Part"
      render 'edit'
    else
      if @template.update_attributes(params[:computer_template]) then
        redirect_to [:admin, @template]
      else
        render 'edit'
      end
    end
  end
  
  def show
    @template = ComputerTemplate.find(params[:id])
    @parts = @template.parts.split(",")
  end

  def edit
    @template = ComputerTemplate.find(params[:id])
  end

  def destroy
    @template = ComputerTemplate.find(params[:id])
    @template.destroy

    redirect_to admin_computer_template_path
  end

  def index
    @templates = ComputerTemplate.all
  end
end
