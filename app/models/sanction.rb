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

    #stores the array of years.
    years = ["Todos",1988, 1991, 1992, 1995, 1996, 1997, 1998, 1999, 2000, 2001, 2002,
             2003, 2004, 2005, 2006, 2007, 2008, 2009, 2010, 2011, 2012, 2013,
             2014, 2015]
    return years 

  end

  # updates the the process number of the sanction.
  def refresh!

    # stores the process number of the sanction.
    s = Sanction.find_by_process_number(self.process_number)

  end

  # calculates the percentage of sanctions for the graphs.
  def self.percentual_sanction(value)

      # it's the number of total of sanctions.
      total = Sanction.all.count
      # receives the percentage of the total.
      return value * 100.0 / total

  end

end	
