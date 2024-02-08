require 'sidekiq/web'

Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check

  devise_for :users

  authenticate :user do
    mount Sidekiq::Web => '/sidekiq'
  end

  resources :citizens, except: [:destroy] do
    collection do
      get :data
      get :cities
    end
  end

  root "citizens#index"
end
