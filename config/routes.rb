Rails.application.routes.draw do

  devise_for :admin
 
  namespace :admin do
    get 'dashboards', to: 'dashboards#index'
    resources :users, only: [:destroy]
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  scope module: :public do
    devise_for :users
    resources :users do
      delete 'unsubscribe', on: :member
    end

    root to: "homes#top"

    resources :maintenances, only: [:new, :create, :index, :show, :edit, :update, :destroy] do
      resources :maintenance_comments, only: [:create, :destroy]
      resource :favorites, only: [:create, :destroy]
    end
    resources :users, only: [:index, :show, :edit, :update]

    get '/search', to: 'searches#search'
  end
end
