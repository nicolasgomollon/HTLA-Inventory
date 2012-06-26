class ComputerTemplate < ActiveRecord::Base
  # attr_accessible :title, :body
  attr_accessible :name, :parts
  
  def part_array= (array)
    self.parts = array.join ","
  end
  
  def part_array
    self.parts.split ","
  end
end
