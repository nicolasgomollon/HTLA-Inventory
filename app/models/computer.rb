class Computer < ActiveRecord::Base
  attr_accessible :brand, :idtag, :location, :model, :serial, :number, :computer_parts_attributes

  validates :serial, :presence => true, :uniqueness => true
  validates :idtag, :presence => true, :uniqueness => true
  
  has_many :computer_parts
  
  has_many :computer_ownerships
  has_many :students, :through => :computer_ownerships
  has_many :repair_orders

  accepts_nested_attributes_for :computer_parts
  
  def get_current_student
    self.computer_ownerships.order("startdate DESC").each do |ownership|
      return ownership.student if ownership.current?
    end
    return nil
  end
  
  def create_parts(template)
    return false unless self.computer_parts.empty?
    
    template.parts.split(",").each do |part|
      self.computer_parts.new(:name => part).save
    end
    
    self.model = template.name if self.model.nil?
    return true
  end
  
  def parts
    hash = {}
    self.computer_parts.each do |part|
      hash[part.name] = part
    end
    return hash
  end  
end
