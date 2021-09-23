# frozen_string_literal: true

Rails.application.routes.draw do
  root 'election_results#index'
  resources :election_results, only: [:index] do
    collection do
      get 'search'
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
