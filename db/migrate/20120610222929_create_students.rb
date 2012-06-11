class CreateStudents < ActiveRecord::Migration
  def change
    create_table :students do |t|
      t.string :firstname
      t.string :lastname
      t.integer :studentid
      t.integer :classof

      t.timestamps
    end
  end
end
