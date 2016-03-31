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