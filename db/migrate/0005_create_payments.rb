class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
      t.string :identifier, :default => ""
      t.string :process_number, :default => ""
      t.float :initial_value
      t.date :sign_date
      t.date :start_date
      t.date :end_date
      t.belongs_to :enterprise
    end
  end
end