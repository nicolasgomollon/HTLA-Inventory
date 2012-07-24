class Computer < ActiveRecord::Base
  attr_accessible :brand, :idtag, :location, :model, :serial, :number, :computer_parts_attributes, :location_id

  validates :serial, :presence => true, :uniqueness => true
  validates :idtag, :presence => true, :uniqueness => true
  
  has_many :computer_parts
  
  has_many :computer_ownerships
  has_many :students, :through => :computer_ownerships
  has_many :repair_orders

  belongs_to :location

  accepts_nested_attributes_for :computer_parts

  comma do
    model 'Computer Model'
    idtag 'Tag'
    serial 'Serial'

    computer_parts {|parts| 
      tmp = ""
      parts.all.each { |part| tmp+= "#{part.name} #{(part.status ? "Good" : "Bad")}: #{part.description} " unless part.status} 
      tmp}

    get_current_student :nicename => 'Student Holder'
  end
  
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

  def bad?
    self.computer_parts.each do |part|
      return true unless part.status
    end
    return false
  end

  def good?
    return !bad?
  end  
end
