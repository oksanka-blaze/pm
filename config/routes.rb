Pm::Application.routes.draw do
  devise_for :users

  resources :projects do
    resources :tasks, only: [:index, :new, :create]
  end

  resources :tasks, only: [] do
    patch :assign, on: :member
  end

  root 'projects#index'
end
