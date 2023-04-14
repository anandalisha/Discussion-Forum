Rails.application.routes.draw do
  
  root 'discussions#index'
  
  use_doorkeeper
  namespace :api do
    namespace :v1 do
      resources :channels, only: [:create, :destroy, :update, :show]
    end
  end

  scope :api do
    scope :v1 do
      use_doorkeeper do
        skip_controllers :authorization, :applications, :authorized_applications
      end
    end
  end

  namespace :api do
    namespace :v1 do
      resources :replies, only: [:create, :destroy, :update, :show]
    end
  end

  scope :api do
    scope :v1 do
      use_doorkeeper do
        skip_controllers :authorization, :applications, :authorized_applications
      end
    end
  end


  namespace :api do
    namespace :v1 do
      resources :likes, only: [:create, :destroy]
    end
  end
  
  scope :api do
    scope :v1 do
      use_doorkeeper do
        skip_controllers :authorization, :applications, :authorized_applications
      end
    end
  end



  namespace :api do
    namespace :v1 do
     resources :discussions, only: [:index, :show, :create, :update, :destroy]
    end
  end

  scope :api do
    scope :v1 do
      use_doorkeeper do
        skip_controllers :authorization, :applications, :authorized_applications
      end
    end
  end

  
  get 'search', to: 'search#index'
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  resources :channels
  resources :discussions do
    resources :replies
  end
  resources :likes, only: [:create, :destroy]

  devise_for :users, controllers: { registrations: 'registrations' }
end
