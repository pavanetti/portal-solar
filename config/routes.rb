Rails.application.routes.draw do
  post 'search/simple'
  post 'search/advanced'
  root to: 'power_generators#index'
  resources :home, only: %i[index]
end
