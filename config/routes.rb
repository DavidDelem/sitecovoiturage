Rails.application.routes.draw do
  devise_for :members
  resources :members, only: [:show] do

    # Routes personalisées nécessaires en plus des routes classiques de rail

    get 'preferences', to: 'members#preferences'
    post 'preferences', to: 'members#updatepreferences'
    get 'changeimage', to: 'members#changeimage'
    post 'changeimage', to: 'members#upload'
    get 'suppression', to: 'members#suppression'

    resources :trajets do

      # Routes personalisées nécessaires en plus des routes classiques de rail

      get 'reservation', to: 'reservation#show'
      get 'paiement', to: 'reservation#paiement'
      get 'confirmation', to: 'reservation#confirmation'
      delete 'reservation', to: 'reservation#delete'
      get 'avis', to: 'reservation#avis'
      post 'avis', to: 'reservation#avisupdate'
    end
  end

  resources :search

  root :to =>'home#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
