Rails.application.routes.draw do

  root 'homepages#index'

  
  devise_for :users, skip: [:sessions]
  devise_for :users, path: '',
  path_names: {
    sign_in: 'login',
    sign_out: 'logout',
  }
  
  resources :admin, only: [:index]
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
  
  resources :resources, only: [:index, :show]
  
  get "/*id" => 'pages#show', as: :page, format: false
end
