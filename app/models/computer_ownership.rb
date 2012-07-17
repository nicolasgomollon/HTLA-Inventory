class ComputerOwnership < ActiveRecord::Base
  attr_accessible :enddate, :startdate, :student_id, :computer_id
  
  belongs_to :computer
  belongs_to :student
  
  def current?
    return true if self.enddate.nil?
    return false
  end
end
