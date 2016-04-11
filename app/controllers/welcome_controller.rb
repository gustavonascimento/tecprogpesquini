# File: welcome_controller.rb
# Purpouse: Controls the actions relative to the welcome model.
# License: GPL v3
# Group 10 Tecprog
# FGA - Universidade de Brasília - Campus Gama

class WelcomeController < ApplicationController

  def index

    params[:q][:cnpj_eq] = params[:q][:corporate_name_cont] unless params[:q].nil?
    @search = Enterprise.search(params[:q].try(:merge, m: 'or'))
    @enterprises = @search.result
    
  end
  
end
