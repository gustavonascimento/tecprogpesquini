# File: user.rb
# Purpouse: The state model
# License: GPL v3
# Group 10 Tecprog
# FGA - Universidade de Brasília - Campus Gama

class State < ActiveRecord::Base

  has_many :sanctions
  validates_uniqueness_of :abbreviation

  def refresh!
    s = State.find_by_abbreviation(self.abbreviation)
  end

  def self.all_states
    states = ["BA", "DF", "RJ", "PA", "MG", "SP", "AM", "RS", "SC", "ES", "PR",
     "PB", "RN", "CE", "AL", "RR", "SE", "RO","PI" , "AC",
    "TO", "GO", "PE", "AP", "MS", "MT", "MA","Não Informado"]
    return states
  end

end