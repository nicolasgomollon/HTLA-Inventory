class AddUniqueIndexToStudentId < ActiveRecord::Migration
  def up
  	add_index :students, :studentid, :unique => true
  end

  def down
  	remove_index :students, :studentid
  end
end
