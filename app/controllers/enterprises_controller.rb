# File: session_controller.rb
# Purpouse: Controls the actions relative to the session model.
# License: GPL v3
# Group 10 Tecprog
# FGA - Universidade de Brasília - Campus Gama

class EnterprisesController < ApplicationController

  # controls the enterprises search.
  def index

    if params[:q].nil?
      # Used to keep the result of a search of a enterprise.
      @search = Enterprise.search(params[:q].try(:merge, m: 'or'))
      # shows the result of the search.
      @enterprises = Enterprise.paginate(:page => params[:page], :per_page => 10)
    else
      params[:q][:cnpj_eq] = params[:q][:corporate_name_cont]
      @search = Enterprise.search(params[:q].try(:merge, m: 'or'))
      @enterprises = @search.result.paginate(:page => params[:page], :per_page => 10)
    end

  end

  # communicates with the view to show enterprises attributes.
  def show

    # keeps how many results of the enterprise search can be show in one page.
    @per_page = 10

    # calculates the page number.
    @page_num = params[:page].to_i > 0 ? params[:page].to_i  - 1 : 0

    # shows the result of the search for enterprises.
    @enterprise = Enterprise.find(params[:id])

    # stores the sanctions of the searched enterprise.
    @collection = Sanction.where(enterprise_id: @enterprise.id)

    # stores the payments of the searched enterprise.
    @payments = Payment.where(enterprise_id: @enterprise.id).paginate(:page => params[:page], :per_page => @per_page )

    # stores the collections, wich has the sanctions.
    @sanctions = @collection.paginate(:page => params[:page], :per_page => @per_page)

    # stores the position of the enterprise ordained by the payments received.
    @payment_position = enterprise_payment_position(@enterprise)

    # stores the position of the enterprise
    @position = Enterprise.enterprise_position(@enterprise)

  end

  # controls the position of every enterprise
  def enterprise_payment_position(enterprise)

    # stores the featured paymensts of the enterprise.
    p = Enterprise.featured_payments  
      p.each_with_index do |a, index|
        if a.payments_sum == enterprise.payments_sum
          return index + 1 
        else
          # nothing to do
        end

      end

    end
    
  end
