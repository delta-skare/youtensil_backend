Rails.application.routes.draw do
  resources :profiles
  resources :tips
  devise_for :users, defaults: { format: :json }
  post "/search" => "yelp#search"
  get 'profiles/:user_id/tips' => 'tips#show_user_tips'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
