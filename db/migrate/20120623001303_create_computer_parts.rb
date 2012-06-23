class CreateComputerParts < ActiveRecord::Migration
  def change
    create_table :computer_parts do |t|
      t.boolean :status
      t.string  :description
      t.integer :computer_id
      t.timestamps
    end
  end
end
