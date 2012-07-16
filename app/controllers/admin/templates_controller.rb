
class Admin::TemplatesController < Admin::AdminController
  def new
  end
  
  def create
    @template = ComputerTemplate.new(:name => params[:name],
                                    :parts => params[:parts])
    @template.save
    
    redirect_to admin_template_path(@template)
  end
  
  def show
    @template = ComputerTemplate.find(params[:id])
    @parts = @template.parts.split(",")
  end
end
