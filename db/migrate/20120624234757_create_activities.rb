class CreateActivities < ActiveRecord::Migration
  def change
    create_table :activities do |t|
      t.date :date
      t.string :message
      t.string :desc
      
      #Associations
      t.integer :student_id
      t.integer :repair_order_id

      t.timestamps
    end
    
    create_table :repair_orders do |t|
      t.date :startdate
      t.date :enddate
      
      #Associations
      t.integer :computer_id
    end
    
    create_table :bills do |t|
      t.string :desc
      t.float :amount
      
      t.boolean :labor
      t.boolean :paid, :default => false
      
      #Associations
      t.integer :repair_order_id
    end
    
    change_table :students do |t|
      t.integer :access, :default => 0
    end
  end
end
