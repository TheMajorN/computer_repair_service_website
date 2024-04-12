Rails.application.routes.draw do
  devise_for :users
  root 'tickets#index' # Set the root path to tickets#index

  resources :tickets

  get '/check_status', to: 'tickets#status', as: 'check_status_tickets'
  get '/services', to: 'tickets#services', as: 'services_and_prices'
  get '/about', to: 'tickets#about', as: 'about'

  namespace :admin do
    resources :tickets
  end
end