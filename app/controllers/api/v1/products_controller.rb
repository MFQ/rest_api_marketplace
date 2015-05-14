module Api
	module V1 
		class ProductsController < ApplicationController

			before_action :authenticate_with_token!, only: [:create]

			def show
				@product = Product.find(params[:id])
				render json: @product, status: 200
			end

			def index
				@products = Product.all
				render json: { products: @products, status: 200 }
			end

			def create
				product = current_user.products.build(product_params)
				if product.save
					render json: product, status: 201, location: [:api, product]
				else
					render json: { errors: product.errors }, status: 422
				end
			end

			private

			def product_params
				params.require(:product).permit(:title, :price, :published)
			end

		end
	end
end