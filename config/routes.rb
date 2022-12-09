# frozen_string_literal: true

Rails.application.routes.default_url_options[:host] = ENV["URL"] || "localhost:3000"

Rails.application.routes.draw do
  root to: "welcome#show"
  get "/home", to: "home#show"
  get "/sign_in" => "sessions#new", as: :sign_in
  resource :session, controller: "sessions", only: %i[new create destroy]

  namespace :manage do
    root to: "manage#show"
    get :switch_accounts, to: "switch_accounts#show", constraints: ->(req) { req.format == :js }

    resources :organizations, only: [] do
      get "dashboard", to: "dashboards#show"
      resources :employees, except: %i[show]
      namespace :settings do
        resource :organization, only: %i[edit update]
        resource :meta_data, only: %i[edit]
        resources :vessels, except: %i[index]
      end
    end
  end

  if Rails.env.development? || Rails.env.test?
    post "session_without_csrf", to: "sessions#create_without_csrf"
  end
end
