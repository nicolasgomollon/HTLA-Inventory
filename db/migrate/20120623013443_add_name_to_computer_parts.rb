class AddNameToComputerParts < ActiveRecord::Migration
  def change
    change_table :computer_parts do |t|
      t.string :name
    end
  end
end
