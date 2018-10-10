Rails.application.routes.draw do
  resources :profiles
  resources :tips
  devise_for :users, defaults: { format: :json }
  post "/search" => "yelp#search"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
