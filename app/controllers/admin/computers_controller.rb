
class Admin::ComputersController < ApplicationController
  def index
    @computers = Computer.all
  end
  
  def show
    @computer = Computer.find(params[:id])
  end
end
