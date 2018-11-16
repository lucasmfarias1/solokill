Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  root to: "home#index"

  post 'home/verify', to: 'home#verify'
  delete 'home/verify', to: 'home#unverify'

  post 'home/image', to: 'home#set_image'

  get '/challenger', to: 'home#index', defaults: { filter: 'CHALLENGER' }
  get '/master', to: 'home#index', defaults: { filter: 'MASTER' }
  get '/diamond', to: 'home#index', defaults: { filter: 'DIAMOND' }
  get '/platinum', to: 'home#index', defaults: { filter: 'PLATINUM' }
  get '/gold', to: 'home#index', defaults: { filter: 'GOLD' }
  get '/silver', to: 'home#index', defaults: { filter: 'SILVER' }
  get '/bronze', to: 'home#index', defaults: { filter: 'BRONZE' }

  resources :users, only: [:show]
  resources :posts, only: [:show, :create, :destroy]

  get '/sync', to: 'users#sync_elo'
end
