class CreateStudents < ActiveRecord::Migration
  def change
    create_table :students do |t|
      t.string :firstname
      t.string :lastname
      t.number :studentid
      t.index :studentid
      t.number :classof

      t.timestamps
    end
  end
end
