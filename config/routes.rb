Rails.application.routes.draw do
  resources :commands

  # Configure API routes to get the mod's zip file.
  # Either the last uploaded or the last updated mod?
  namespace :api do
    namespace :v1 do
      get 'download_latest_mod', to: 'dashboard#download_latest_mod'
      get 'check_current_version', to: 'dashboard#check_current_version'
      # Test endpoint now takes a mod id as a parameter
      get 'tests', to: 'dashboard#test_latest', as: :test_latest
      get 'test/mod/:id', to: 'dashboard#test_mod', as: :test_mod
      get 'command_test', to: 'dashboard#command_test'
    end
  end

  resources :mods
  get 'pages/home'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  root "pages#home"
end
