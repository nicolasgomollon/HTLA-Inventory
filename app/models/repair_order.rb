class RepairOrder < ActiveRecord::Base
  attr_accessible :startdate, :enddate, :computer_id
  
  after_initialize do
    self.startdate = Date.today
  end
  
  def open(description)
    return false unless self.activities.empty?
    self.activities.new(:desc => description, :message => Activity::Messages[:created]).save
    self
  end
  
  def close(description)
    return false if self.activities.empty?
    self.activities.new(:desc => description, :message => Activity::Messages[:closed]).save
    self
  end

  def description
    self.activities.first.desc
  end
  
  def open?
    return true if self.enddate.nil?
    return true if self.enddate > Date.today
    return false
  end
  
  belongs_to :computer
  has_many :activities
  has_many :bills
end