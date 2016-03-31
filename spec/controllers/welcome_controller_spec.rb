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