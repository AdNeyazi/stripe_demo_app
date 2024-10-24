# frozen_string_literal: true

# db/migrate/20241024082254_create_payments.rb
class CreatePayments < ActiveRecord::Migration[7.1]
  def change
    create_table :payments do |t|
      t.integer :amount
      t.string :stripe_charge_id
      t.string :status
      t.string :email

      t.timestamps
    end
  end
end
