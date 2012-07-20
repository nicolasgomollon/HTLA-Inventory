class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
    	t.string :name
      t.timestamps
    end

    change_table :computers do |t|
    	t.integer :location_id
    end
  end
end
