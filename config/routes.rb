# Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: "users/registrations",
    sessions: 'users/sessions'
  }

  root "pages#home"

  resources :plants
  get 'plants/:id/summary', to: 'plants#show_summary', as: 'plant_summary'

  resources :locations
  resources :locations, only: [:show] do
    get 'plants/index', to: 'locations#list_plants', as: 'plants'
    get 'search_plants', as: 'search_plants'
    post 'plants/add_plant', to: 'locations#add_plant', as: 'add_plant'
    delete 'plants/remove_plant', to: 'locations#remove_plant', as: 'remove_plant'
    resources :notes
  end

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check
end
