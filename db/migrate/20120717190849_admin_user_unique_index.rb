class AdminUserUniqueIndex < ActiveRecord::Migration
  def up
  	add_index :admin_users, :username, :unique => true
  end

  def down
  	remove_index :admin_users, :username
  end
end
