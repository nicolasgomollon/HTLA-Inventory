class Activity < ActiveRecord::Base
  attr_accessible :date, :desc, :message
  
  Messages = { 
    :created => "Created New Repair Order",
    :closed  => "Closed Repair Order"
  }
  
  after_initialize do
    self.date = Date.today
  end

  belongs_to :student
  belongs_to :repair_order
end
