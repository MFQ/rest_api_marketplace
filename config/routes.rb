Rails.application.routes.draw do
  #APi namespace 

  namespace :api, defaults:{ format: :json}, constraints: {subdomain: 'api'}, path: '/' do
  # We are going to list our resources here
  end
 
end
