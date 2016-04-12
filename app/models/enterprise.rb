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
  def last_sanction
    
    sanction = self.sanctions.last
      unless sanction.nil?    
        self.sanctions.each do |s|
          sanction = s if s.initial_date > sanction.initial_date
        end
      end
    return sanction

  end

  # informs the last payment received by the enterprise.
  def last_payment
    
    payment = self.payments.last
      unless payment.nil?
        self.payments.each do |f|
          payment = f if f.sign_date > payment.sign_date
        end
      end
    return payment

  end

  #  tells if there were any payments after a sanction.
  def payment_after_sanction?
    
    sanction = last_sanction
    payment = last_payment
      
      if sanction && payment
        payment.sign_date < sanction.initial_date
      else
        false
      end

  end

  # refresh the enterprises searched by CNPJ.
  def refresh!

    # stores all the enterprises that have been searched in this method .
    e = Enterprise.find_by_cnpj(self.cnpj)
  
  end


  # organizes the enterprises position accordingly to the amount of sanctions suffered.
  def self.enterprise_position(enterprise)

      orderedSanc = self.featured_sanctions
      groupedSanc = orderedSanc.uniq.group_by(&:sanctions_count).to_a

      groupedSanc.each_with_index do |k,index|
        if k[0] == enterprise.sanctions_count
          return index + 1
        end
      end

  end

  # shows that the most sanctioned companies.
  def self.most_sanctioned_ranking
    
    enterprise_group = []
    enterprise_group_count = []
    @enterprise_group_array = []
    a = Enterprise.all.sort_by{|x| x.sanctions_count}
    b = a.uniq.group_by(&:sanctions_count).to_a.reverse

    b.each do |k|
      enterprise_group << k[0]
      enterprise_group_count << k[1].count
    end
      @enterprise_group_array << enterprise_group
      @enterprise_group_array << enterprise_group_count
      @enterprise_group_array
  
  end

end
