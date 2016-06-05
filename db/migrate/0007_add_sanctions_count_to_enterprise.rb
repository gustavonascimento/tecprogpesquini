# File: 0006_add_sacntion_organ_to_sanction.rb
# Purpouse: migrates the data from the santions count and takes it to enterprise,
# ... beacause it was in the wrong place , to the application, taking it of the database 
# ... defining the types of each variable.
# License: GPL v3
# Group 10 Tecprog
# FGA - Universidade de Brasília - Campus Gama

class AddSanctionsCountToEnterprise < ActiveRecord::Migration
  def change

    add_column :enterprises, :sanctions_count, :integer, :default => 0
    
  end
end
