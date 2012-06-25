class Activity < ActiveRecord::Base
  attr_accessible :date, :desc, :message
  
  belongs_to :student
  belongs_to :repair_order
end
