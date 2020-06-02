Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      post '/login', to: 'sessions#create'
      post '/signup', to: 'users#create'
    end
  end
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :users, only: %i[show update destroy] do
        resources :products, only: %i[create update destroy]
      end
      resources :products, only: %i[index show]
    end
  end


end
