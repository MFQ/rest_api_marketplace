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

		end
	end
end
