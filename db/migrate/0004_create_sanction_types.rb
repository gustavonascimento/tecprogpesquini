# File: 0004_create_sanction_types.rb
# Purpouse: migrates the data from the sanction_types, to the application, taking it of the database 
# ... defining the types of each variable.
# License: GPL v3
# Group 10 Tecprog
# FGA - Universidade de Brasília - Campus Gama

class CreateSanctionTypes < ActiveRecord::Migration
	def change

		create_table :sanction_types do |t|
			t.string :description
			t.string :legal_foundation
			t.string :foundation_description
			
		end
	end
end