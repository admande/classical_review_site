Rails.application.routes.draw do
  devise_for :users

  resources :welcome, only: [:index]

  resources :pieces
  root "pieces#index"
end
