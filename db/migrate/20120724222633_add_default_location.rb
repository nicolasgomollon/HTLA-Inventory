class AddDefaultLocation < ActiveRecord::Migration
  def up
  	location = Location.create(name: "Unknown")
  	Computer.all.each do |computer| 
  		computer.update_attributes(location_id: location.id)
  	end
  end

  def down
  	Location.delete_all
  	Computer.all.each do |computer| 
  		computer.update_attributes(location_id: nil)
  	end  	
  end
end
