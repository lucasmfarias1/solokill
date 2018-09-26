Rails.application.routes.draw do
  get 'home/index'
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "home#index"
  post 'home/index', to: 'home#new_post'
  post 'home/verify', to: 'home#verify'
end
