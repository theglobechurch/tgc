Rails.application.routes.draw do

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
    end
  end

end
