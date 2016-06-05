# File: 0008_create_users.rb
# Purpouse: migrates the data from the users, to the application, taking it of the database 
# ... defining the types of each variable.
# License: GPL v3
# Group 10 Tecprog
# FGA - Universidade de Brasília - Campus Gama

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