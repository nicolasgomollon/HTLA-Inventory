class AddRememberToken < ActiveRecord::Migration
  def change
  	change_table :admin_users do |t|
  		t.text :remember_token
  	end
  end
end
