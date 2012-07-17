class CreateAdminUsers < ActiveRecord::Migration
  def change
    create_table :admin_users do |t|
    	t.text :password_digest
    	t.text :username
    	t.text :fullname
    	t.index :username, :unique => true
      t.timestamps
    end
  end
end
