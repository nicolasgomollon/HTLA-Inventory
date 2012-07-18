class AddUniqueIndexToComputerTag < ActiveRecord::Migration
  def up
  	add_index :computers, :idtag, :unique => true
  	remove_index :computers, :serial
  	add_index :computers, :serial, :unique => true
  end

  def down
  	remove_index :computers, :idtag
  	remove_index :computers, :serial
  	add_index :computers, :serial
  end
end
