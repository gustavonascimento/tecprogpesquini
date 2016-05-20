# File: parser_payment_controller.rb
# Purpouse: Does the parser of payment with the file in the csv format.
# License: GPL v3
# Group 10 Tecprog
# FGA - Universidade de Brasília - Campus Gama

class Parser::ParserPaymentController < Parser::ParserController

  require 'csv'
  require 'open-uri'
  @@filename = 'parser_data/CEIS.csv'

  before_filter :authorize, only: [:check_nil_ascii, :check_date, :import, 
                                       :build_state, :build_sanction_type, 
                                       :build_enterprise, :build_sanction, 
                                       :check_and_save]

  def index

  end

  # checks the value of the payment taken of the file.
  def check_value(text)

    #this method recieves a string representing a payment value in the format 19,470.99
    #Then it takes off the comma (",") and parse it to float format as 19470.99
     begin
      return text.gsub(",","").to_f
    rescue
      return nil
    end

  end

  # imports the parser file.
  def import()

    constante = 0
    Enterprise.find_each do |enterprises|

      url = 'http://compras.dados.gov.br/contratos/v1/contratos.csv?cnpj_contratada='
      begin
        data =  open(url+enterprises.cnpj).read
        csv = CSV.parse(data, :headers => true, :encoding => 'ISO-8859-1')

        csv.each_with_index do |row, i|
          payment = Payment.new
          payment.identifier = check_nil_ascii(row[0])
          payment.process_number = check_nil_ascii(row[10])
          payment.initial_value = check_value(row[16])
          payment.sign_date = check_date(row[12])
          payment.start_date = check_date(row[14])
          payment.end_date = check_date(row[15])
          payment.enterprise = enterprises
          enterprises.payments_sum = enterprises.payments_sum + payment.initial_value
          check_and_save(enterprises)
          check_and_save(payment)
        end
      rescue
        constante = constante +   1
      end
    end
    puts "="*50
    puts "Quantidade de empresas sem pagamentos: ", constante

  end

  # checks and save the data from the file.
  def check_and_save(data)

    begin
      data.save!
      data
    rescue ActiveRecord::RecordInvalid
      data = data.refresh!
      data
    end
    
  end

end
