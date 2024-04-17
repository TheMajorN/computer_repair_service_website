Rails.application.routes.draw do
  devise_for :users
  root 'tickets#index'

  resources :tickets, only: [:index, :new, :create, :update]

  get '/check_status', to: 'tickets#status', as: 'check_status_tickets'
  get '/services', to: 'tickets#services', as: 'services_and_prices'
  get '/about', to: 'tickets#about', as: 'about'

  namespace :admin do
    resources :tickets, only: [:index, :show, :update]
  end
end