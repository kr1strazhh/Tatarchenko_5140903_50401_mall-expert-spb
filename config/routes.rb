Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  namespace :api do
    namespace :v1 do
      get "malls", to: "malls_api#index"
      post "malls", to: "malls_api#create"
    end
  end

  scope "(:locale)", locale: /ru|en/ do
    root "malls#index"
    get "malls", to: "malls#index", as: :malls
    get "signup", to: "users#new", as: :signup
    post "signup", to: "users#create"
    get "login", to: "sessions#new", as: :login
    post "login", to: "sessions#create"
    delete "logout", to: "sessions#destroy", as: :logout
    resource :profile, only: [:show] do
      get "export"
    end
  end
end
