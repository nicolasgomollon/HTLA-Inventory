class AddIdToComputer < ActiveRecord::Migration
  def change
    change_table :computers do |t|
      t.index :serial
    end 
  end
end
