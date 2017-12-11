Rails.application.routes.draw do
  
  root to: 'restaurants#index'
  resources :restaurants

  # resource not resources
  resource :session, only: [:new, :create, :destroy] 
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
