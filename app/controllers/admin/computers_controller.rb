require 'csv'

class Admin::ComputersController < Admin::AdminController
  def index
    query = ""
    query_array = []
    query = query_helper :serial, params[:serial], query, query_array
    query = query_helper :idtag, params[:serial], query, query_array

    @computers = Computer.where(query, *query_array) unless query.empty?
    if @computers then
      redirect_to [:admin, @computers.first] if @computers.length == 1
    end
  
    @tag = params[:tag]
    @serial = params[:serial]
  end
  
  def show
    @computer = Computer.find(params[:id])
    @repair = @computer.repair_orders.new
  end
  
  def new
    @computer = Computer.new
    do_templates
  end
  
  def edit
    @computer = Computer.find(params[:id])
    @location_select = []
    @location_select << [@computer.location.name, @computer.location_id] if @computer.location
    Location.all.each do |location|
      @location_select << [location.name, location.id] unless @location_select.include? [location.name, location.id]
    end
  end
  
  def update
    @computer = Computer.find(params[:id])
    @computer.update_attributes(params[:computer])    
    if !@computer.save then
      do_templates
      render 'edit'
    else
      redirect_to admin_computer_path(@computer)
    end
  end
  
  def create
    @template = ComputerTemplate.find(params[:template_id])
    @computer = Computer.create(params[:computer])
    if @computer.save then
      @computer.create_parts(@template)
      redirect_to edit_admin_computer_path(@computer)  
    else 
      do_templates
      render 'new'
    end
    
  end

  def import
  end

  def upload
    if params[:csv] then
      csv = CSV.new(params[:csv].read, {:headers => true})
      @count = 0
      csv.each do |row| 
        if !@template = ComputerTemplate.find_by_name(row['Model']) then
          @template = ComputerTemplate.new(name: row['Model'])
          @template.save
        end
        computer = Computer.new({
            :idtag => row['Computer Name'],
            :serial => row['Serial']
        })
        @count += 1 if computer.save
        computer.create_parts(@template)
      end
    end
  end

  def do_templates
    templates = ComputerTemplate.all
    @template_select = []
    templates.each do |template|
      @template_select.push([template.name, template.id])
    end
  end
end
