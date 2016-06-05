# File: 0005_create_payments.rb
# Purpouse: migrates the data from the payments, to the application, taking it of the database 
# ... defining the types of each variable.
# License: GPL v3
# Group 10 Tecprog
# FGA - Universidade de Brasília - Campus Gama

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