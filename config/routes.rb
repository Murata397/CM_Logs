Rails.application.routes.draw do
  devise_for :users
  resources :users do
    delete 'unsubscribe', on: :member
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: "homes#top"
  resources :maintenances, only: [:new, :create, :index, :show, :edit, :update, :destroy]
  resources :users, only: [:index, :show, :edit, :update]
  get '/search', to: 'searches#search'
end
