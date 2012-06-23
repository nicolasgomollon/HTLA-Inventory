class CreateComputerTemplates < ActiveRecord::Migration
  def change
    create_table :computer_templates do |t|
      t.string :parts
      t.timestamps
    end
  end
end
