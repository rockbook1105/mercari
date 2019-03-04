Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    omniauth_callbacks: "users/omniauth_callbacks"
  }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'products#index'
  resources :mypage, only: [:index] do
    collection do
      get "notification"
      get "todo"
    end
  end
  scope module: "mypage" do
    get "mypage/like/history" , to: "likes#history"
  end
  resources :products do
    resources :purchase, only: [:new, :create], module: :products
    resource :publications, only: [:update, :destroy], module: :products
  end
  resources :users, only: :edit

  namespace :users do
    namespace :sign_up do
      get 'address', to: 'address#new'
      get 'payment_methods', to: 'payment_methods#new'
      get "registration", to: "registration#index"
      get 'registration', to: 'registration#new'

      resources :address, only: [:create]
      resources :payment_methods, only: [:create]
      resources :done, only: [:index]
    end
  end
end
