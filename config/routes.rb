Rails.application.routes.draw do
  root 'users#index'
  # Ресурс пользователей (экшен destroy не поддерживается)
  resources :users
  resources :questions, only: %i[edit update destroy create]

  resource :session, only: %i[new create destroy]
  resources :hashtags, only: :show, param: :text
end

