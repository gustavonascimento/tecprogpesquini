# File: 0001_create_enteprises.rb
# Purpouse: migrates the data from the enterprises, to the application, taking it of the database 
# ... defining the types of each variable.
# License: GPL v3
# Group 10 Tecprog
# FGA - Universidade de Brasília - Campus Gama

class CreateEnterprises < ActiveRecord::Migration 
	def change

		create_table :enterprises do |t|
			t.string :cnpj
			t.string :corporate_name
			t.string :sanction_organ
			
		end
	end
end