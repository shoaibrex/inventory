Rails.application.routes.draw do
  resources :categories
  devise_for :users
  resources :orders do
    get :print
  end
  resources :members
  resources :users
  resources :items do
    member do
      get 'update_stock'
      put 'stock'
    end
  end
  resources :logs
  root 'orders#index'
  get 'renew/:id' => 'orders#renew'
  get 'return/:id' => 'orders#disable'
  get 'past_orders' => 'orders#old'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
