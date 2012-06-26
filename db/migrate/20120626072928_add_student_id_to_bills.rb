class AddStudentIdToBills < ActiveRecord::Migration
  def change
    change_table :bills do |t|
      t.integer :student_id
    end
  end
end
