class ComputerTemplate < ActiveRecord::Base
  # attr_accessible :title, :body
  attr_accessible :name, :parts, :parts_array

  after_initialize do
  	self.parts ||= "Screen,Hard Drive,Shell,Battery,Hinges,Keyboard,Charger"
  end

  validates_presence_of :name
  validates_presence_of :parts
  
  def parts_array= (array)
  	if array.respond_to? 'join' then
		self.parts = array.join "," 
	else
		self.parts = array
	end
  end
  
  def parts_array
  	return self.parts.split "," if self.parts
  	[]
  end
end
