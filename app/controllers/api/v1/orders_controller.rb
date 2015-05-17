module Api
	module V1
		class OrdersController < ApplicationController
			before_action :authenticate_with_token!
  		respond_to :json

		  def index
		    render json: current_user.orders, status: 200
		  end

		  def show
		  	render json: current_user.orders.find(params[:id])
		  end

		  def create
		  	order = current_user.orders.build(order_params)
		  	if order.save
		  		render json: order, status: 201, location: [:api, current_user, order]
		  	else
		  		render json: { errors: order.errors }, status: 422
		  	end
		  end

		  private

		  def order_params
		  	params.require(:order).permit(:total, :user_id, :product_ids => [])
		  end

		end
	end
end
