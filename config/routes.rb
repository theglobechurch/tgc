Rails.application.routes.draw do

  root 'homepages#index'

  devise_for :users, skip: %i[sessions]
  devise_for :users,
             path: '',
             path_names: {
               sign_in: 'login',
               sign_out: 'logout',
             }

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

    post :graphics, to: 'graphics#create'
  end

  get 'preaching/:id', to: 'resources#series'
  get :preaching, to: 'resources#index'

  resources :resources, only: %i[show]
  get :resources, to: redirect('/preaching')

  get "/*id" => 'pages#show', as: :page, format: false
end
