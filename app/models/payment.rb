# File: payment.rb
# Purpouse: The payment model, contains all information about payments for enterprises.
# License: GPL v3
# Group 10 Tecprog
# FGA - Universidade de Brasília - Campus Gama


class Payment < ActiveRecord::Base

  belongs_to :enterprise

  validates_uniqueness_of :process_number

  # finds the payment related with its process, which is the CNPJ of the enterprise.
  def refresh!
  	
  	# stores the payments found.
    payments_process_number = Payment.find_by_process_number(self.process_number)
    
  end

end