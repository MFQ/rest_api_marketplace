module Api
	module V1 
		class ProductsController < ApplicationController

			def show
				@product = Product.find(params[:id])
				render json: @product, status: 200
			end

			def index
				@products = Product.all
				render json: { products: @products, status: 200 }
			end

		end
	end
end