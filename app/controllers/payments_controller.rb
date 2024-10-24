# frozen_string_literal: true

# app/controllers/payments_controller.rb
class PaymentsController < ApplicationController
  def create
    @amount = params[:amount].to_i * 100 # Amount is in cents

    if process_payment(@amount, params[:stripeToken], params[:stripeEmail])
      redirect_to success_path, notice: 'Payment was successful!'
    else
      redirect_to new_payment_path, alert: 'There was an error processing your payment.'
    end
  end

  def history
    @payments = if params[:email].present?
                  Payment.where(email: params[:email])
                else
                  []
                end
  end

  def success; end

  private

  def process_payment(amount, stripe_token, email)
    charge = create_charge(amount, stripe_token, email)
    save_payment_details(amount, charge, email) if charge
  end

  def create_charge(amount, stripe_token, email)
    Stripe::Charge.create(
      amount: amount,
      currency: 'usd',
      source: stripe_token,
      description: 'Test Payment',
      receipt_email: email # Email from Stripe form
    )
  rescue Stripe::CardError => e
    flash[:alert] = e.message
    nil # Return nil to indicate failure
  end

  def save_payment_details(amount, charge, email)
    Payment.create!(
      amount: amount,
      stripe_charge_id: charge.id,
      status: charge.status,
      email: email # Save the email from the payment form
    )
  end
end
