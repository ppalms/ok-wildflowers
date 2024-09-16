# Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: "users/registrations",
    sessions: 'users/sessions'
  }

  root "pages#home"

  resources :plants
  get 'plants/:id/summary', to: 'plants#show_summary', as: 'plant_summary'

  get "locations" => "locations#index"
  resources :locations
  resources :locations, only: [:show] do
    member do
      get 'search_plants'
      post 'add_plant'
      delete 'remove_plant'
    end
    resources :notes
  end

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check
end
