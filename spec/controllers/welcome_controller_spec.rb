# File: application_controller_spec.rb
# Purpouse: Makes a unit test for the welcome controller
# License: GPL v3
# Group 10 Tecprog
# FGA - Universidade de Brasília - Campus Gama

require 'rails_helper'

RSpec.describe WelcomeController, :type => :controller do 

  describe "GET" do 

    describe '#index' do

      it "sdould work" do 

        get :index
        expect(response).to have_http_status(:success)

      end

    end

  end

end
