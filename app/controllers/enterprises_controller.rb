# File: session_controller.rb
# Purpouse: Controls the actions relative to the session model.
# License: GPL v3
# Group 10 Tecprog
# FGA - Universidade de Brasília - Campus Gama

class EnterprisesController < ApplicationController

  # controls the enterprises search.
  # @param @enterprises
  def index

    # This part of the code controls the search, passing the params 
    # ... through the view and getting int othe controller
    if params[:q].nil?

      # used to keep the result of a search of a enterprise.
      @result_of_search = Enterprise.search(params[:q].try(:merge, m: 'or'))

      # number of items to display
      @per_page = 10

      # shows the result of the search.
      @enterprises = Enterprise.paginate(:page => params[:page], :per_page => @per_page)

      Preconditions.check_not_nil(@result_of_search)
      Preconditions.check_not_nil(@enterprises)

    else

      params[:q][:cnpj_eq] = params[:q][:corporate_name_cont]
      @result_of_search = Enterprise.search(params[:q].try(:merge, m: 'or'))
      @enterprises = @result_of_search.result.paginate(:page => params[:page], :per_page => @per_page)

    end

    return @enterprises

  end

  # calculates the page number
  # @param @page_number
  def show_page_number()

    if params[:page].to_i > 0
      @page_number = params[:page].to_i  - 1
    else
      @page_number = 0
    end

    assert @page_number > 0, "Unvalid page number"
    return @page_number

  end

  # communicates with the view to show enterprises attributes.
  # @param @position_pf_enterprise
  def show

    # keeps how many results of the enterprise search can be show in one page.
    @per_page = 10

    # calculates the page number.
    @page_number = show_page_number()

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
    @position_of_enterprise = Enterprise.enterprise_position(@enterprise)

    assert @position_of_enterprise > 0, "Invalid position of enterprise value"
    return @position_of_enterprise

  end

  # controls the position of every enterprise
  def enterprise_payment_position(enterprise)

    # stores the featured paymensts of the enterprise.
    payments_of_enterprise = Enterprise.featured_payments

      #This part of the code will compare two enterprises at a time to see if 
      # ... they have the same pósition on the ranking.  
      payments_of_enterprise.each_with_index do |a, index|
        if a.payments_sum == enterprise.payments_sum
          return index + 1 
        else
          # nothing to do
        end

      end

  end
  
end
