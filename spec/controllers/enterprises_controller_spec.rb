# File: enterprise_controller_spec.rb
# Purpouse: Makes a unit test for the enterprise controller
# License: GPL v3
# Group 10 Tecprog
# FGA - Universidade de Brasília - Campus Gama

require 'rails_helper'

RSpec.describe EnterprisesController, :type => :controller do 

  before do

    @enterprise = Enterprise.create(cnpj: "12345")
    @payment= Payment.create
    @enterprise.payments << @payment
    @sanction = Sanction.create
    @enterprise.sanctions << @sanction

  end

  describe "GET" do 

    describe '#index' do

      it "should work" do 

        get :index
        expect(response).to have_http_status(:success)

      end


    end
    
    describe '#show' do

      describe 'with a registered enterprise' do 

        it "should work" do

          get :show, :id => @enterprise.id
          expect(response).to have_http_status(:success)

        end
         it "should show the correct enterprise" do
            get :show, :id => @enterprise.id
            expect( assigns( :enterprise ) ).to eq( @enterprise )
        end

        it "should show the enterprise's payments" do
            get :show, :id => @enterprise.id
            expect( assigns( :payments ) ).to include( @payment )
        end

        it "should show the enterprise's sanctions" do
            get :show, :id => @enterprise   .id
            expect( assigns ( :sanctions ) ).to include( @sanction )
        end

      end

    end

  end
  
end