class CreateAdminUsers < ActiveRecord::Migration
  def change
    create_table :admin_users do |t|
    	t.text :password_digest
    	t.text :username
    	t.text :fullname
      t.timestamps
    end
  end
end
