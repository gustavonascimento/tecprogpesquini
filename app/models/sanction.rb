# File: sanction.rb
# Purpouse: The sanction model,  contains all informations about sanctions.
# License: GPL v3
# Group 10 Tecprog
# FGA - Universidade de Brasília - Campus Gama

class Sanction < ActiveRecord::Base

  belongs_to :enterprise, counter_cache: true
  belongs_to :sanction_type
  belongs_to :state

  validates_uniqueness_of :process_number

  scope :by_year, lambda { |year| where('extract(year from initial_date) = ?', year) }

  # returns one array of years, for the sanctions.
  def self.all_years

    # years of data sanction stored
    years = []
    for x in 1995..2015
      years << x
    end

    # even more years of data sanction stored.
    years.unshift("Todos", 1988, 1991, 1992)

    return years 
    
    Preconditions.check_not_nil(years)
    assert years.empty?, "Array years should contain the years in analysis in the system."

  end

  # updates the the process number of the sanction.
  def refresh!

    # stores the process number of the sanction.
    sanctions_process_number = Sanction.find_by_process_number(self.process_number)
    return sanctions_process_number

    Preconditions.check_not_nil(sanctions_process_number)

  end

  # calculates the percentage of sanctions for the graphs.
  def self.percentual_sanction(value)

      # it's the number of total of sanctions.
      total = Sanction.all.count
      # receives the percentage of the total.
      percent_total = value * 100.0 / total
      return percent_total

      Preconditions.check(total) {is_not_nil and has_type(Interger) and satisfies("> 0") {total > 0}}
      Preconditions.check(value) {is_not_nil and has_type(Double)}

  end

end	
