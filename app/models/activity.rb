class Activity < ActiveRecord::Base
  Messages = { 
    :created => "Created New Repair Order"
  }
  
  attr_accessible :date, :desc, :message
  
  belongs_to :student
  belongs_to :repair_order
end
