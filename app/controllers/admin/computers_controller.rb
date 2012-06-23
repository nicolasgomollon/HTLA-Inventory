
class Admin::ComputersController < ApplicationController
  def index
    query = ""
    query_array = []
    if !params[:serial].nil? then
      if !params[:serial].empty? then
        query += " serial LIKE ?"
        query_array.push("%#{params[:serial]}%")
      end
    end 
    if !params[:tag].nil? then
      if !params[:tag].empty? then
        query += " OR " if !query.empty?
        query += "idtag LIKE ?"
        query_array.push("%#{params[:tag]}%")
      end
    end
    @computers = Computer.where(query, *query_array) if !query.empty?
  
    @tag = params[:tag]
    @serial = params[:serial]
  end
  
  def show
    @computer = Computer.find(params[:id])
  end
  
  def new
    @computer = Computer.new
    templates = ComputerTemplate.all
    @template_select = []
    templates.each do |template|
      @template_select.push([template.name, template.id])
    end
  end
  
  def edit
    @computer = Computer.find(params[:id])
  end
  
  def update
    @computer = Computer.find(params[:id])
    @computer.update_attributes(params[:computer])
    
    params[:part].each do |key, part_params|
      part = @computer.computer_parts.find(part_params[:id].to_i)
      part.description = part_params[:description]
      part.status = part_params[:status].to_bool
      part.save
    end 
    
    @computer.save
    
    redirect_to admin_computer_path(@computer)
  end
  
  def create
    template = ComputerTemplate.find(params[:template_id])
    computer = Computer.new()
    computer.update_attributes(params[:computer])
    computer.brand = template.name
    template.parts.split(",").each do |part|
      computer.computer_parts.new(:name => part)
    end
    computer.save
    
    redirect_to edit_admin_computer_path(computer)
  end
end
