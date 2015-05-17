require 'api_constraints'

RestApiMarketplace::Application.routes.draw do
  devise_for :users
  #APi namespace 

  namespace :api, defaults:{ format: :json}, constraints: {subdomain: 'api'}, path: '/' do
  
    scope module: :v1, constraints: ApiConstraints.new(version: 1, defaults: true) do
      # We are going to list our resources here

      resources :users, only:[:show, :create, :update, :destroy]
      resources :sessions, only:[:create, :destroy]
      resources :products, only:[:show, :index, :create, :update, :destroy]
      resources :orders, only:[:index, :show, :create]

    end
  end
 
end
