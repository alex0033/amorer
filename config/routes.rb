Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'jobs#index'
  get 'policy', to: 'basic_pages#policy'
  devise_for :users, :controllers => { :registrations => :registrations }
  resources :users,    only: :show
  resources :jobs
  resources :entries,  only: [:create, :destroy]
  resources :messages, only: [:index, :new, :create, :show]
end
