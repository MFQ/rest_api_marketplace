require 'api_contraints'
Rails.application.routes.draw do
  #APi namespace 

  namespace :api, defaults:{ format: :json}, constraints: {subdomain: 'api'}, path: '/' do
  
    scope module: :v1, constraints: ApiContraints.new(version: 1, defaults: true) do
      # We are going to list our resources here
    end
  end
 
end
