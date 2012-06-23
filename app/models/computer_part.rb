class ComputerPart < ActiveRecord::Base
  # attr_accessible :title, :body
  attr_accessible :status, :description, :name
  
  belongs_to :computer
end
