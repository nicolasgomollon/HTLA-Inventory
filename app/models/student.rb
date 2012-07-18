class Student < ActiveRecord::Base
  attr_accessible :classof, :firstname, :lastname, :studentid, :access
  
  has_many :computer_ownerships
  has_many :computers, :through => :computer_ownerships
  has_many :bills
  
  def nicename
    "#{self.firstname} #{self.lastname}"
  end

  def current_computer
  	self.computer_ownerships.each do |ownership|
  		return ownership.computer if ownership.current?
  	end
  	return nil
  end
end
