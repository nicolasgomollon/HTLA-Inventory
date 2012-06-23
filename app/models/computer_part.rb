class ComputerPart < ActiveRecord::Base
  # attr_accessible :title, :body
  attr_accessible :status, :description, :name
  
  belongs_to :computer
  
  after_initialize :init
  
  def init
    self.description ||= ""
    self.status ||= true
  end
end
