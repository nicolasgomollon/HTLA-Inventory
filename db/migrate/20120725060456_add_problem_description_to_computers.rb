class AddProblemDescriptionToComputers < ActiveRecord::Migration
  def change
  	change_table :computers do |t|
  		t.string :problem
  	end
  end
end
