class Bill < ActiveRecord::Base
  attr_accessible :desc, :amount, :labor, :paid

  validates_presence_of :desc
  validates_presence_of :amount
  
  belongs_to :repair_order
  belongs_to :student
end