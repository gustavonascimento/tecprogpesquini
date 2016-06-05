# File: 0006_add_paymnets_sum_to_enterprise.rb
# Purpouse: migrates the data from the payments sum and takes it to enterprise,
# ... beacause it was in the wrong place , to the application, taking it of the database 
# ... defining the types of each variable.
# License: GPL v3
# Group 10 Tecprog
# FGA - Universidade de Brasília - Campus Gama

class AddPaymentsSumToEnterprise < ActiveRecord::Migration
  def change

    add_column :enterprises, :payments_sum, :float, :default => 0
    
  end
end
