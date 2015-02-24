require 'api_constraints'

RestApiMarketplace::Application.routes.draw do
  devise_for :users
  #APi namespace 

  namespace :api, defaults:{ format: :json}, constraints: {subdomain: 'api'}, path: '/' do
  
    scope module: :v1, constraints: ApiConstraints.new(version: 1, defaults: true) do
      # We are going to list our resources here
    end
  end
 
end
