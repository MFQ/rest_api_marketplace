require 'rails_helper'
require 'spec_helper'


describe Api::V1::UsersController do
  before(:each) { request.headers['Accept'] = "application/vnd.marketplace.v1, #{Mime::JSON}" }
  before(:each) { request.headers['Content-Type'] == Mime::JSON.to_s }

  describe "GET #show" do 
    before(:each) do 
      @user = FactoryGirl.create :user
      get :show, id: @user.id
    end

    it "returns the information about the users in hash" do 
      user_response = json_response[:user]
      expect(user_response[:email]).to eql @user.email
    end

    it { should respond_with 200 }

  end

  describe "POST #create" do
    context "when is successfully created." do
      before(:each) do
        @user_attributes = FactoryGirl.attributes_for :user
        post :create, { user: @user_attributes } 
      end

      it "rendered the json representation for the user just created" do
        user_response = json_response[:user]
        expect(user_response[:email]).to eql @user_attributes[:email]
      end

      it { should respond_with 201 }
    end

    context "when is not created." do
      before(:each) do
        ## notice I am not including the email

        @invalid_user_attributes = {
          password: "12345678",
          password_confirmation: "12345678"
        }
        post :create, {user: @invalid_user_attributes}
      end

      it "render an error json" do
        user_response = json_response
        expect(user_response).to have_key(:errors)
      end

      it "rendered an error why the user was not created" do
        user_response = json_response
        expect(user_response[:errors][:email]).to include "can't be blank"
      end

      it { should respond_with 422 }
    end
  end

  describe "PUT/PATCH #update" do
    context "when is successfully updated" do 
      before(:each) do 
        @user = FactoryGirl.create :user
        request.headers['Authorization'] =  @user.auth_token
        patch :update, { id: @user.id, user: { email:"newemail@example.com" } }
      end

      it "rendered json representation for updaed user" do 
        user_response = json_response
        expect(user_response[:user][:email]).to eql "newemail@example.com"
      end

      it { should respond_with 201 }
    end

    context "when is not created" do 
      before(:each) do 
        @user = FactoryGirl.create :user
        request.headers['Authorization'] =  @user.auth_token
        patch :update, { id: @user.id, user: { email: "bademail.com" } }
      end

      it "render an error json" do
        user_response = json_response
        expect(user_response).to have_key(:errors)
      end

      it "renderes the json errors why user was not updated" do 
        user_response = json_response
        expect(user_response[:errors][:email]).to include "is invalid"
      end

      it { should respond_with 422 }
    end
  end

  describe "DELETE #destroy" do 
    before(:each) do 
      @user = FactoryGirl.create :user
      request.headers['Authorization'] =  @user.auth_token
      delete :destroy, { id: @user.id}
    end

    it { should respond_with 204 }

  end

end
