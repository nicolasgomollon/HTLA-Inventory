class ComputerOwnership < ActiveRecord::Base
  attr_accessible :enddate, :startdate, :student_id, :computer_id
  
  belongs_to :computer
  belongs_to :student
end
