require 'rails_helper'

# RSpec.describe SessionsController, type: :controller do

# end

describe Api::V1::SessionsController do 

	describe "POST #create" do
		before(:each) do 
			@user = FactoryGirl.create :user
		end

		context "when credentials are correct" do
			before(:each) do 
				credentials = { email: @user.email, password: "12345678" }
				post :create, { session: credentials }
			end

			it "return user record coressponding credentials" do 
				@user.reload
				expect(json_response[:user][:auth_token]).to eql @user.auth_token
			end
			it { should respond_with 200 }

		end

		context "when credentials are incorrect" do
			before(:each) do 
				credentials = {email: @user.email, password: "invalide_password"}
				post :create, { session: credentials }
			end

			it "return an error json message" do 
	      expect(json_response[:errors]).to eql "Invalid email or password"
			end

			it { should respond_with 422 }
		end

	end

	describe "DELETE #destroy" do

    before(:each) do
      @user = FactoryGirl.create :user
      sign_in @user, store: false
      delete :destroy
    end

  end

end