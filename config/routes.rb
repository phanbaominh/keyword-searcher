# frozen_string_literal: true

Rails.application.routes.draw do
  root 'home#index'
  resources :election_results, only: [:index]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
