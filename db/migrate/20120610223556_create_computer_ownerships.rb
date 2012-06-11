class CreateComputerOwnerships < ActiveRecord::Migration
  def change
    create_table :computer_ownerships do |t|
      t.integer :id
      t.date :startdate
      t.date :enddate
      t.references :computer
      t.references :student

      t.timestamps
    end
  end
end
