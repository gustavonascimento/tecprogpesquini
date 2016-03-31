class CreateUsers < ActiveRecord::Migration 
	def change
		create_table :users do |t|
			t.string :login
			t.string :password_digest
			t.string :remember_token
			t.string :type
		end
	end
end