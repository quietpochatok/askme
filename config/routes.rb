Rails.application.routes.draw do
  root 'users#index'
  # Ресурс пользователей (экшен destroy не поддерживается)
  resources :users, except: [:destroy]
  resources :questions
  resources :sessions, only: [:new, :create, :destroy]
  get 'sign_up' => 'users#new'
  get 'log_in' => 'sessions#new'
  get 'log_out' => 'sessions#destroy'
end

