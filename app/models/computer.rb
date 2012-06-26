class Computer < ActiveRecord::Base
  attr_accessible :brand, :idtag, :location, :model, :serial, :number
  
  has_many :computer_parts
  
  has_many :computer_ownerships
  has_many :students, :through => :computer_ownerships
  has_many :repair_orders
  
  def get_current_student
    self.computer_ownerships.order("startdate DESC").each do |ownership|
      return ownership.student if ownership.current?
    end
  end
end
