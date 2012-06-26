class Student < ActiveRecord::Base
  attr_accessible :classof, :firstname, :lastname, :studentid, :access
  
  has_many :computer_ownerships
  has_many :computers, :through => :computer_owernships
  has_many :bills
  
  def nicename
    "#{self.firstname} #{self.lastname}"
  end
end
