
class Admin::ComputersController < ApplicationController
  def index
    query = ""
    query_array = []
    query = query_helper :serial, params[:serial], query, query_array
    query = query_helper :idtag, params[:tag], query, query_array

    @computers = Computer.where(query, *query_array) unless query.empty?
  
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
    @template = ComputerTemplate.find(params[:template_id])
    @computer = Computer.new()
    @computer.update_attributes(params[:computer])
    @computer.brand = @template.name
    @template.parts.split(",").each do |part|
      @computer.computer_parts.new(:name => part)
    end
    @computer.save
    
    redirect_to edit_admin_computer_path(@computer)
  end
end
