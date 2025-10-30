Rails.application.routes.draw do

  devise_for :admin, skip: [:registrations, :password], controllers: {
    sessions: 'admin/sessions'
  }
  namespace :admin do
    get 'dashboards', to: 'dashboards#index'
    resources :users, only: [:destroy]
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  scope module: :public do
    devise_for :users, controllers: {
      registrations: "public/registrations",
      sessions: 'public/sessions' 
    }
    resources :users do
      delete 'unsubscribe', on: :member
    end

    root to: "homes#top"

    resources :maintenances, only: [:new, :create, :index, :show, :edit, :update, :destroy] do
      resources :maintenance_comments, only: [:create, :destroy]
      resource :favorites, only: [:create, :destroy]
    end
    resources :users, only: [:index, :show, :edit, :update]
    resources :cars, only: [:new, :create, :index, :show, :edit, :update, :destroy]
    resources :fuel_efficiency, only: [:new, :create, :index, :show, :edit, :update, :destroy]
    get '/search', to: 'searches#search'
  end
end
