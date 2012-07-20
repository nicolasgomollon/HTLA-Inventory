class Bill < ActiveRecord::Base
  attr_accessible :desc, :amount, :labor, :paid, :repair_order_id

  validates_presence_of :desc
  validates_presence_of :amount
  validates_presence_of :repair_order_id

  after_create do
  	unless self.student then
  		self.student = self.repair_order.computer.get_current_student if self.repair_order.computer.get_current_student
  	end
  end
  
  belongs_to :repair_order
  belongs_to :student
end