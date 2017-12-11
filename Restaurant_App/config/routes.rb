Rails.application.routes.draw do
  
  root to: 'session#new'
  resources :restaurants

  # could also include index, i guess if there was a reason to show all users?
  resources :users, only: [:new, :create, :show]

  # resource not resources
  resource :session, only: [:new, :create, :destroy] 
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
