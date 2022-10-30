Rails.application.routes.draw do
  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
  }
  devise_for :customers,skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
  }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  
  
  scope module: :public do
    root to: "homes#top"
    get "home/about" => "homes#about", as: "about"
    resources :items, only: [:index, :show]
    resources :customers, only: [:show, :edit, :update]
    get "customer/quit" => "customers#quit"
    patch "customer/out" => "customers#out"
    delete "/cart_items/destroy_all" => "cart_items#destroy_all", as: "destroy_all_cart_items"
    resources :cart_items, only: [:index, :update, :destroy, :create]
    resources :orders, only: [:show, :index, :new, :create]
    post "order/confirm" => "orders#confirm"
    get "order/thanx" => "orders#thanx"
    resources :addresses, only: [:index, :edit, :update, :destroy, :create]
  end
  
  namespace :admin do
    root to: "homes#top"
    resources :items, only: [:new, :create, :index, :show, :edit, :update]
    resources :genres, only: [:create, :index, :edit, :update]
    resources :customers, only: [:show, :index, :edit, :update]
    resources :orders, only: [:show, :update]
    resources :order_details, only: [:update]
  end
end
