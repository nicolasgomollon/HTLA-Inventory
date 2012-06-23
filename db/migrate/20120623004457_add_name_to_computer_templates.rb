class AddNameToComputerTemplates < ActiveRecord::Migration
  def change
    change_table :computer_templates do |t|
      t.string :name
    end

  end
end
