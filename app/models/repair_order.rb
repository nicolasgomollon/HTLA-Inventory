  class RepairOrder < ActiveRecord::Base
  attr_accessible :startdate, :enddate, :computer_id

  belongs_to :computer
  has_many :activities
  has_many :bills

  validate :has_activities

  after_initialize do
    self.startdate = Date.today
  end

  def has_activities
    errors[:base] << "No activities!" if self.activities.count == 0
  end

  def description
    self.activities.first.desc
  end
  
  def open?
    return true if self.enddate.nil?
    return true if self.enddate > Date.today
    return false
  end
end