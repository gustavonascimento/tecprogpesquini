# File: welcome_controller.rb
# Purpouse: Controls the actions relative to the welcome model.
# License: GPL v3
# Group 10 Tecprog
# FGA - Universidade de Brasília - Campus Gama

class WelcomeController < ApplicationController

  # gives the result from the search for enterprises in the welcome page.
  def index

    params[:q][:cnpj_eq] = params[:q][:corporate_name_cont] unless params[:q].nil?

    # receives the search.
    @search = Enterprise.search(params[:q].try(:merge, m: 'or'))

    # stores the result of the search.
    @enterprises = @search.result
    
  end
  
end
