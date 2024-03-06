Rails.application.routes.draw do

  # Configure API routes to get the mod's zip file.
  # Either the last uploaded or the last updated mod?
  namespace :api do
    namespace :v1 do
      get 'download_latest_mod', to: 'dashboard#download_latest_mod'
      get 'check_current_version', to: 'dashboard#check_current_version'
      get 'test', to: 'dashboard#test_stuff'
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
