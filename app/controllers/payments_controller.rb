class PaymentsController < ApplicationController
    skip_before_action :verify_authenticity_token
  
  
    def index
      @payments = Payment.all
      render json: @payments
    end
  
   
    def show
      render json: @payment
    end
  
   
    def create
      debugger
     order= Order.find(params[:payment][:order_id])
     customer = order.customer
       @payment = Payment.new(payment_params.merge(order: order))
      @payment.stripe_id = customer.stripe_id
      if @payment.save
        render json: @payment, status: :created
      else
        render json: @payment.errors, status: :unprocessable_entity
      end
    end
  
   
    def update
      if @payment.update(payment_params)
        render json: @payment
      else
        render json: @payment.errors, status: :unprocessable_entity
      end
    end
  
  
    def destroy
      debugger
      @payment = Payment.find(params[:payment][:id])

      @payment.destroy
      head :no_content
    end
  
    private
  
    def set_payment
      @payment = Payment.find(params[:id])
    end
  
    def payment_params
      params.require(:payment).permit(:order_id, :number, :exp_month, :exp_year, :cvc)
    end
  end