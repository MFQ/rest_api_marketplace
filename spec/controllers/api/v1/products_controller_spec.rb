require 'rails_helper'

RSpec.describe Api::V1::ProductsController, type: :controller do

	describe "GET #show" do
		before(:each) do
			@product = FactoryGirl.create :product 
			get :show, id: @product.id
		end

		it "will return product hash " do 
			product_respone = json_response
			expect(product_respone[:title]).to eq(@product.title)
		end

		it { should respond_with 200 }
	end

	describe "GET #index" do
		before(:each) do
			5.times { FactoryGirl.create :product }
			get :index
		end

		it "will return products " do
			product_respone = json_response
			expect(product_respone[:products].length).to eq(5)
		end

		it { should respond_with 200 }

	end

end
