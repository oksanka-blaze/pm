Pm::Application.routes.draw do
  devise_for :users

  resources :projects do
    resources :tasks, only: [:index, :new, :create]
  end

  root 'projects#index'
end
