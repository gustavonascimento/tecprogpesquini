# File: enterprise.rb
# Purpouse: The enterprise model, informs all the details on enterprises.
# License: GPL v3
# Group 10 Tecprog
# FGA - Universidade de Brasília - Campus Gama

class Enterprise < ActiveRecord::Base

  # stores the sanctions relationated to each enterprise.
  has_many :sanctions
  # stores the payments that the enterprise received.
  has_many :payments
  validates_uniqueness_of :cnpj

  scope :featured_sanctions, -> (number=nil){number ? order('sanctions_count DESC').limit(number) :order('sanctions_count DESC')}
  scope :featured_payments, -> (number=nil){number ? order('payments_sum DESC').limit(number) :order('payments_sum DESC')}

  # informs the last sanctions suffered from the enterprise.
  # @param sanction.
  def last_sanction
    
    # Stores the sanction received last by the enterprise. 
    sanction = self.sanctions.last
      
      if not sanction.nil?

        self.sanctions.each do |sanction_found|
          
          # This following block of code if will compare 
          # ... the initial and last dates of the sanctions, 
          # ... making the last date, a new variable.
          if sanction_found.initial_date > sanction.initial_date
            sanction = sanction_found
          else
          # nothing to do
          end

        end
    
    end

    return sanction

    Preconditions.check_not_nil(sanction_found)

    assert @sanction.empty?, "Sanction object must not be null"

  end

  # informs the last payment received by the enterprise.
  # @param payment.
  def last_payment

    # Stores the last payment of the enterprise    
    payment = self.payments.last
      
      unless payment.nil?
     
        self.payments.each do |founded_payment|
     
          if founded_payment.sign_date > payment.sign_date
            payment = founded_payment
          else
            # nothing to do
          end
     
        end
     
      end
    
    return payment

    Preconditions.check_not_nil(founded_payment)

    assert @payment.empty?, "Payment object must not be null"


  end

  # tells if there were any payments after a sanction.
  # @param payment.
  def payment_after_sanction?
    
    # Stores the last sanction of the enterprise  
    sanction = last_sanction
    # Stores the last payment of the enterprise  
    payment = last_payment
      
      # The following if will confirm if in fact there is a payment after the 
      # ... sanction, comparing the payment sign date and the sanction initial date.
      if sanction && payment
        payment.sign_date < sanction.initial_date
      else
         return false
      end

      return payment

  end

  # refresh the enterprises searched by CNPJ.
  # @param enterprises_return_search
  def refresh!

    Preconditions.check_not_nil(cnpj)

    # stores all the enterprises that have been searched in this method .
    enterprises_return_search = Enterprise.find_by_cnpj(self.cnpj)

    return enterprises_return_search
  
  end


  # organizes the enterprises position accordingly to the amount of sanctions suffered.
  def self.enterprise_position(enterprise)

      # stores the sanctions of the enterprise, but its ordered.
      orderedSanc = self.featured_sanctions

      # stores the sanctions of the enterprise, but its groupes and its transformed
      # in a array.
      groupedSanc = orderedSanc.uniq.group_by(&:sanctions_count).to_a

      groupedSanc.each_with_index do |k,index|
        if k[0] == enterprise.sanctions_count
          return index + 1
        else
          # nothing to do
        end
      end

  end

  # shows that the most sanctioned companies.
  def self.most_sanctioned_ranking
    
    # Variable initialized to store the group of enterprises most sanctioned,
    # to show in the ranking
    enterprise_group = []

    # Stores the number of enterprise with the same number of sanctions
    enterprise_group_count = []

    # Stores an array of enterprise, with the same count of sanctions
    @enterprise_group_array = []
    a = Enterprise.all.sort_by{|x| x.sanctions_count}
    b = a.uniq.group_by(&:sanctions_count).to_a.reverse

    # This block of code will do paginations
    # ... and the order of the ranking of enterprises
    b.each do |k|
      enterprise_group << k[0]
      enterprise_group_count << k[1].count
    end
      @enterprise_group_array << enterprise_group
      @enterprise_group_array << enterprise_group_count

    return @enterprise_group_array

    assert @enterprise_group_array.empty?, "Enterprise array must not be null"

  
  end

end
