Rails.application.routes.draw do
  devise_for :users

  # Routes PWA (obligatoires en Rails 8)
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Ressources RESTful principales
  resources :events do
    # On ajoute l'index pour l'espace admin (liste des participants)
    resources :attendances, only: [ :index, :create ]
  end

  resources :users, only: [ :show ]

  # Stripe Checkout : On utilise un scope ou des routes nommées
  # car Stripe n'est pas une ressource CRUD classique de ton app
  scope "/checkout" do
    post "create", to: "checkout#create", as: "checkout_create"
    get "success", to: "checkout#success", as: "checkout_success"
    get "cancel", to: "checkout#cancel", as: "checkout_cancel"
  end

  root "home#index"
end
