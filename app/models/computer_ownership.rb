class ComputerOwnership < ActiveRecord::Base
  attr_accessible :enddate, :startdate, :student_id, :computer_id
  
  belongs_to :computer
  belongs_to :student
  
  def current?
    if @enddate.nil?
      return true
    else
      if @enddate > Date.today
        return true
      end
    end
    false
  end
end
