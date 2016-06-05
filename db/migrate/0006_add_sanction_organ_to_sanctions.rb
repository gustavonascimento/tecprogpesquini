# File: 0006_add_sacntion_organ_to_sanction.rb
# Purpouse: migrates the data from the santions organ and takes it to sanctions,
# ... beacause it was in the wrong place , to the application, taking it of the database 
# ... defining the types of each variable.
# License: GPL v3
# Group 10 Tecprog
# FGA - Universidade de Brasília - Campus Gama

class AddSanctionOrganToSanctions < ActiveRecord::Migration
  def change

    add_column :sanctions, :sanction_organ, :string, :default => ""
    remove_column :enterprises, :sanction_organ
    
  end 
end
