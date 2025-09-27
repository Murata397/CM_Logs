Rails.application.routes.draw do
  devise_for :users
  resources :users do
    delete 'unsubscribe', on: :member
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: "homes#top"
  resources :users, only: [:show, :edit, :update]
end
