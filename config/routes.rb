Rails.application.routes.draw do
  root 'users#index'

  # Ресурс пользователей (экшен destroy не поддерживается)
  resources :users, except: [:destroy]
  resources :questions
end

