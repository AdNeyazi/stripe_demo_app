# frozen_string_literal: true

Rails.application.routes.draw do
  get 'payments/history', to: 'payments#history'
  get 'success', to: 'payments#success'
  resources :payments
  root 'payments#new'
end
