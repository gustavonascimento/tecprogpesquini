# File: parser_controller.rb
# Purpouse: Does the parser with the file in the csv format.
# License: GPL v3
# Group 10 Tecprog
# FGA - Universidade de Brasília - Campus Gama

class Parser::ParserController < ApplicationController

  require 'csv'
  
  # stores the .csv file.
  @@filename = 'parser_data/CEIS.csv'

  before_filter :authorize, only: [:check_nil_ascii, :check_date, :import, 
                                       :build_state, :build_sanction_type, 
                                       :build_enterprise, :build_sanction, 
                                       :check_and_save]

  def index

  end

  # makes sure that there isn't empty ascii characters in the csv file.
  def check_nil_ascii(text)

    if text.include?("\u0000")
      return "Não Informado"
    else
      return text.upcase
    end

  end

  # checks the date.
  def check_date(text)

    begin
      return text.to_date
    rescue
      return nil
    end

  end

  # checks and save the data from the file.
  def check_and_save(data)

    # stores all the data from the parser.
    begin
      data.save!
      data
    rescue ActiveRecord::RecordInvalid
      data = data.refresh!
      data
    end

  end

end
