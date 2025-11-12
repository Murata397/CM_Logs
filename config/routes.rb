Rails.application.routes.draw do

  devise_for :admin, skip: [:registrations, :password], controllers: {
    sessions: 'admin/sessions'
  }
  namespace :admin do
    root to: "homes#top"
    get 'dashboards', to: 'dashboards#index'
    resources :users, only: [:destroy]
    resources :groups
    resources :maintenances
    resources :maintenance_comments, only: [:index, :destroy]
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
    resources :fuel_efficiencies, only: [:new, :create, :index, :show, :edit, :update, :destroy]

    resources :groups, only: [:new, :index, :show, :create, :edit, :update] do
      resources :group_users, only: [:create, :destroy]
      resources :event_notices, only: [:new, :create]
      get "event_notices" => "event_notices#sent"
      member do
        delete 'remove_member/:user_id', to: 'groups#remove_member', as: 'remove_member'
      end
      resources :requests, only: [:create, :update]
    end

    get '/search', to: 'searches#search'
  end
end
