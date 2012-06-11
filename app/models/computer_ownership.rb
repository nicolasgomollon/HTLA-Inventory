class ComputerOwnership < ActiveRecord::Base
  attr_accessible :enddate, :startdate, :student_id, :computer_id
  
  belongs_to :computer
  belongs_to :student
  
  def current?
    return true if enddate.nil?
    return false unless enddate >= Date.today
    false
  end
end
