# File: state.rb
# Purpouse: The state model, contains all the information about the States.
# License: GPL v3
# Group 10 Tecprog
# FGA - Universidade de Brasília - Campus Gama

class State < ActiveRecord::Base

  has_many :sanctions
  validates_uniqueness_of :abbreviation

  # refresh the enterprises by state.
  def refresh!

    # receives abbreviation.
    states_abbreviation = State.find_by_abbreviation(self.abbreviation)

  end

  # returns all the initials from all the states.
  def self.all_states

    # array cointaing all the abbreviations of states.
    states = ["BA", "DF", "RJ", "PA", "MG", "SP", "AM", "RS", "SC", "ES", "PR",
     "PB", "RN", "CE", "AL", "RR", "SE", "RO","PI" , "AC",
    "TO", "GO", "PE", "AP", "MS", "MT", "MA","Não Informado"]
    return states

  end

end
