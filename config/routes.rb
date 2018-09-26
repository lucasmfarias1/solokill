Rails.application.routes.draw do
  get 'home/index'
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "home#index"

  post 'home/index', to: 'home#new_post'

  post 'home/verify', to: 'home#verify'

  get '/challenger', to: 'home#index', defaults: { filter: 'CHALLENGER' }
  get '/master', to: 'home#index', defaults: { filter: 'MASTER' }
  get '/diamond', to: 'home#index', defaults: { filter: 'DIAMOND' }
  get '/platinum', to: 'home#index', defaults: { filter: 'PLATINUM' }
  get '/gold', to: 'home#index', defaults: { filter: 'GOLD' }
  get '/silver', to: 'home#index', defaults: { filter: 'SILVER' }
  get '/bronze', to: 'home#index', defaults: { filter: 'BRONZE' }
end
