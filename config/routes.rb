Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  devise_scope :user do
    post "sign_up", to: "registrations#create"
    get "sign_up", to: "registrations#new"
    post "sign_in", to: "sessions#create"
    delete "log_out", to: "sessions#destroy"
  end

  resources :posts, only: [:index, :show, :create, :new]
  resources :peers, only: [:index]





  namespace :api, defaults: {format: :json} do
    namespace :v1 do
      devise_scope :user do
        post "sign_up", to: "registrations#create"
        post "sign_in", to: "sessions#create"
        delete "log_out", to: "sessions#destroy"
      end

      resources :posts, only: [:index, :show, :create]

    end
  end
end
