class ComputerOwnership < ActiveRecord::Base
  attr_accessible :enddate, :startdate, :student_id, :computer_id
  
  belongs_to :computer
  belongs_to :student
  
  def current?
    return true if self.enddate.nil?
    return true if self.enddate >= Date.today
    return false
  end
end
