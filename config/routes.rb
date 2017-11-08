Rails.application.routes.draw do
  devise_for :members
  resources :members, only: [:show] do
    get '/preferences', to: 'members#preferences'
    post '/preferences', to: 'members#updatepreferences'
    resources :trajets do
      get 'reservation'
      get 'confirmation'
    end
  end

  resources :search

  root :to =>'home#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
