class PaymentsController < ApplicationController
  def create
    begin
      payment = Payment.create(payment_params)
      payment.create_payment(params[:token], payment_params)

      render json: { status: :created, payment: payment.reload }
    rescue Stripe::CardError => e
      render json: { status: :unprocessable_entity, errors: e.message }
    rescue StandardError => e
      render json: { status: 500, errors: e.message }
    end
  end

  private

  def payment_params
    params.require(:payment).permit(:booking_id, :amount, :currency, :description)
  end
end
