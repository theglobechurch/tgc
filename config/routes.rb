# rubocop:disable Metrics/BlockLength
Rails.application.routes.draw do

  root 'homepages#index'

  devise_for :users, skip: [:sessions]
  as :user do
    get 'login', to: 'devise/sessions#new', as: :new_user_session
    post 'login', to: 'devise/sessions#create', as: :user_session
    get 'logout', to: 'devise/sessions#destroy', as: :destroy_user_session
  end

  resources :admin, only: %i[index]
  namespace :admin do

    resources :resources do
      member do
        get 'preview'
      end
      collection do
        post :upload, to: 'uploads#create'
      end
    end

    resources :groupings do
      member do
        get 'preview'
      end
    end

    resources :events do
      member do
        get 'preview'
      end
    end
 
    resource :user, only: [:edit] do
      collection do
        patch 'update_password'
      end
    end

    resource :api do
      member do
        get 'resource', to: 'api#resource'
      end
    end

    resources :people
    resources :teams

    post :graphics, to: 'graphics#create'
    post :locations, to: 'locations#create'
  end

  resource :api, only: [:index] do
    member do
      get 'one21', to: 'api#one21'
      get 'resource', to: 'api#resource'
    end
  end

  get :blog, to: 'resources#blog'
  get 'preaching/:id', to: 'resources#series'
  get :preaching, to: 'resources#index'
  get :live, to: 'livestreams#index'

  resources :podcasts, path: :podcast do
    collection do
      get 'sermon'
    end
  end

  resources :resources, only: %i[show]
  get :resources, to: redirect('/preaching')

  resources :events, only: %i[index show]

  resources :people, only: %i[show]

  get "/*id" => 'pages#show', as: :page, format: false
end
