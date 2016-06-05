# File: 0003_create_states.rb
# Purpouse: migrates the data from the states, to the application, taking it of the database 
# ... defining the types of each variable.
# License: GPL v3
# Group 10 Tecprog
# FGA - Universidade de Brasília - Campus Gama

class CreateStates < ActiveRecord::Migration 
	def change

		create_table :states do |t|
			t.integer :code
			t.string :name
			t.string :abbreviation
			
		end
	end
end