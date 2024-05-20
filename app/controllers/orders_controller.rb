class OrdersController < ApplicationController
	skip_before_action :verify_authenticity_token
	def create
	debugger 
		@order = Order.new(order_params)

		if @order.save
			render json: {order: @order, payment: @order.payment_method }, status: :created
		else
			render json: @response.errors, status: :unprocessable_entity
		end
	end

	private
	def order_params
		params.require(:order).permit(:amount_cents, :payment_method, :customer_id)
	end
end
