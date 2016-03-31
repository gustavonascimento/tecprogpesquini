class CreateSanctionTypes < ActiveRecord::Migration
	def change
		create_table :sanction_types do |t|
			t.string :description
			t.string :legal_foundation
			t.string :foundation_description
		end
	end
end