# File: 0002_create_sanctions.rb
# Purpouse: migrates the data from the sanctions, to the application, taking it of the database 
# ... defining the types of each variable.
# License: GPL v3
# Group 10 Tecprog
# FGA - Universidade de Brasília - Campus Gama

class CreateSanctions < ActiveRecord::Migration
	def change

		create_table :sanctions do |t|
			t.date :initial_date
			t.date :final_date
			t.string :process_number
			t.belongs_to :enterprise
			t.belongs_to :sanction_type
			t.belongs_to :state
			
		end
	end
end