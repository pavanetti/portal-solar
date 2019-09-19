Rails.application.routes.draw do
  get 'freights/:state', action: :show, controller: 'freights'
  root to: 'power_generators#index'
  resources :power_generators, only: %i[index show]
  resources :home, only: %i[index]
end
