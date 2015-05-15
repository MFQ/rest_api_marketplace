require 'rails_helper'

RSpec.describe Api::V1::ProductsController, type: :controller do

	describe "DELETE #destroy" do
    before(:each) do
      @user = FactoryGirl.create :user
      @product = FactoryGirl.create :product, user: @user
      request.headers["Authorization"] = @user.auth_token
      delete :destroy, { user_id: @user.id, id: @product.id }
    end

    it { should respond_with 204 }
  end

	describe "PUT/PATCH #update" do

		before(:each) do
      @user = FactoryGirl.create :user
      @product = FactoryGirl.create :product, user: @user
      request.headers["Authorization"] = @user.auth_token
    end

		context "when product gets updated" do 
			
			before(:each) do
				patch :update, { user_id: @user.id, id: @product.id, product: { title: "I am new title" } }
			end

			it "renders the json representation for the updated user" do
        product_response = json_response
        expect(product_response[:product][:title]).to eql "I am new title"
      end

      it { should respond_with 200 }

		end
		context "when product not gets updated" do 

			before(:each) do 
				patch :update, { user_id: @user.id, id: @product.id, product: { price: "two hundred" } }
			end

			it "renders an errors json" do
        product_response = json_response
        expect(product_response).to have_key(:errors)
      end

      it "renders the json errors on whye the user could not be created" do
        product_response = json_response
        expect(product_response[:errors][:price]).to include "is not a number"
      end

      it { should respond_with 422 }

		end
	end

	describe "POST #create" do 

		context "when product is created" do 

			before(:each) do 
				@user = FactoryGirl.create(:user)
				request.headers["Authorization"] = @user.auth_token
        @product_attributes = FactoryGirl.attributes_for :product
				post :create, { user_id: @user.id, product: @product_attributes }
			end

			it "renders the json representation for the product record just created" do 
				product_response = json_response
				expect(product_response[:product][:title]).to eq(@product_attributes[:title])
			end

			it { should respond_with 201 }

		end

		context "whne product is not created" do 

			before(:each) do
				@user = FactoryGirl.create(:user)
				request.headers["Authorization"] = @user.auth_token
				@invalid_product_attributes = { price: "I am price", title: "I am title" }
				post :create, { user_id: @user.id, product: @invalid_product_attributes }
			end

			it "renders an errors json" do
        product_response = json_response
        expect(product_response).to have_key(:errors)
      end

      it "renders the json errors on whye the user could not be created" do
        product_response = json_response
        expect(product_response[:errors][:price]).to include "is not a number"
      end

      it { should respond_with 422 }

		end

	end

	describe "GET #show" do
		before(:each) do
			@product = FactoryGirl.create :product 
			get :show, id: @product.id
		end

		it "will return product hash " do 
			product_response = json_response
			expect(product_response[:product][:title]).to eq(@product.title)
		end

		it { should respond_with 200 }
	end

	describe "GET #index" do
		before(:each) do
			5.times { FactoryGirl.create :product }
			get :index
		end

		it "will return products " do
			product_response = json_response
			expect(product_response[:products].length).to eq(5)
		end

		it { should respond_with 200 }

	end

end
