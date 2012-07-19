class AddLengthToIndicies < ActiveRecord::Migration
  def up
  	remove_index "admin_users", "username"
  	remove_index "computers", "idtag"
  	remove_index "computers", "serial"
  	add_index "admin_users", "username", :length => 40, :unique => true
  	add_index "computers", "idtag", :length => 40, :unique => true
  	add_index "computers", "serial", :length => 100, :unique => true
  end

  def down
  	remove_index "admin_users", "username"
  	remove_index "computers", "idtag"
  	remove_index "computers", "serial"
  	add_index "admin_users", "username", :unique => true
  	add_index "computers", "idtag", :unique => true
  	add_index "computers", "serial", :unique => true
  end
end
