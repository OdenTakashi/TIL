Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check

  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  get "/books/:id" => "books#show"
  delete "books/:id" => "books#detroy"

  resources :publishers
  resource :profile, only: %i[show edit update]
end
