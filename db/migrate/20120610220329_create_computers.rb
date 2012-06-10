class CreateComputers < ActiveRecord::Migration
  def change
    create_table :computers do |t|
      t.string :idtag
      t.string :serial
      t.string :brand
      t.string :model
      t.string :location

      t.timestamps
    end
  end
end
