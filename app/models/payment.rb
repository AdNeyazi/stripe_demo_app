# frozen_string_literal: true

# app/models/payment.rb
class Payment < ApplicationRecord
  validates :amount, presence: true
  validates :stripe_charge_id, presence: true
  validates :status, presence: true
  validates :email, presence: true
end
