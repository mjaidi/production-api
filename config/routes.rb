# ROUTES
Rails.application.routes.draw do
  devise_for :users,
            path: '',
             path_names: {
               sign_in: 'login',
               sign_out: 'logout',
               registration: 'signup'
             },
             controllers: {
               sessions: 'sessions',
               registrations: 'registrations'
             }


  root to: 'pages#home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :elements, only: [:index, :create, :update, :show, :destroy] do
        resources :join_elements, only: [:create, :update, :destroy]
      end
      resources :estimates, only: [:index, :create, :update, :destroy, :show] do
        resources :estimate_elements, only: [:create, :update, :destroy]
      end
    end
  end
end
