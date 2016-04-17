# File: parser_controller_spec.rb
# Purpouse: Makes a unit test for the parser controller
# License: GPL v3
# Group 10 Tecprog
# FGA - Universidade de Brasília - Campus Gama

require 'rails_helper'

RSpec.describe SessionsController, :type => :controller do 
	
	describe   "GET" do 
	
		describe '#new' do
	
			it "should work" do 
	
				get :new
				expect(response).to have_http_status(:success)
	
			end
	
		end
	
	end

end
