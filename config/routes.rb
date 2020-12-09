Rails.application.routes.draw do
  root 'users#index'
  # Ресурс пользователей (экшен destroy не поддерживается)
  resources :users
  resources :questions, only: %i[edit update destroy create]
  resources :sessions, only: %i[new create destroy]
  get 'sign_up' => 'users#new'
  get 'log_in' => 'sessions#new'
  get 'log_out' => 'sessions#destroy'
end

