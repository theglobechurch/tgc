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

    resource :user, only: [:edit] do
      collection do
        patch 'update_password'
      end
    end

    resources :people
    resources :teams

    post :graphics, to: 'graphics#create'
  end

  get 'preaching/:id', to: 'resources#series'
  get :preaching, to: 'resources#index'

  resources :resources, only: %i[show]
  get :resources, to: redirect('/preaching')

  resources :people, only: %i[show]

  get "/*id" => 'pages#show', as: :page, format: false
end
