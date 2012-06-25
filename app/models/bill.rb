class Bill < ActiveRecord::Base
  attr_accessible :desc, :amount, :labor, :paid
  
  belongs_to :repair_order
end