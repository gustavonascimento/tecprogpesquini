class CreateStates < ActiveRecord::Migration 
	def change
		create_table :states do |t|
			t.integer :code
			t.string :name
			t.string :abbreviation
		end
	end
end