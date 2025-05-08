# frozen_string_literal: true

Calagator::Engine.routes.draw do
  # Not sure why, but routes is getting loaded twice. This ignores the second load.
  return unless Calagator::Engine.routes.empty?

  root "site#index"

  # Change routes if registrations are closed
  if Calagator.open_registration
    devise_for :users, class_name: "Calagator::User" if Calagator.devise_enabled
  else
    devise_for :users, skip: [:registrations], class_name: "Calagator::User" if Calagator.devise_enabled
    as :user do
      get "users/sign_up" => "site#closed_registrations", :as => "new_user_registration"
      get "users/edit" => "devise/registrations#edit", :as => "edit_user_registration"
      put "users" => "devise/registrations#update", :as => "user_registration"
    end
  end

  get "omfg" => "site#omfg"
  get "hello" => "site#hello"

  get "about" => "site#about"

  get "opensearch.:format" => "site#opensearch"
  get "defunct" => "site#defunct"

  get "admin" => "admin#index"
  get "admin/index"
  get "admin/events"
  post "lock_event" => "admin#lock_event"

  namespace :admin do
    resources :curations, except: :show
    resources :bulk_imports
    if Calagator.devise_enabled
      resources :users do
        get :invite, as: :invite
      end
    end
  end

  get "embed", to: "site#embed", as: "embed"
  get "curations", to: redirect("/")
  resources :curations, only: :show

  resources :events do
    collection do
      post :squash_many_duplicates
      get :search
      get :duplicates
      get "tag/:tag", action: :search, as: :tag
      get "tabular" => "events#tabular"
    end

    member do
      get :clone
    end
  end

  resources :sources do
    collection do
      post :import
    end
  end

  resources :venues do
    collection do
      post :squash_many_duplicates
      get :map
      get :duplicates
      get :autocomplete
      get "tag/:tag", action: :index, as: :tag
    end
  end

  resources :versions, only: [:edit]
  resources :changes, controller: "/paper_trail_manager/changes"

  get "recent_changes" => redirect("/changes")
  get "recent_changes.:format" => redirect("/changes.%{format}")

  get "css/:name" => "site#style"
  get "css/:name.:format" => "site#style"

  get "/index" => "site#index"
  get "/index.:format" => "site#index"
end
