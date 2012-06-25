class RepairOrder < ActiveRecord::Base
  attr_accessible :startdate, :enddate
  
  belongs_to :computer
  has_many :activities
  has_many :bills
end