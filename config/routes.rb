Rails.application.routes.draw do
    root 'public/homes#top'

devise_for :customers, skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
}



  # 会員側のルーティング設定
scope module: :public do
  get 'customers/quit', to: 'customers#quit', as: 'customer_quit'
  get '/about', to: 'your_controller#your_action', as: 'about'
  get 'quit_confirmation', to: 'customers#quit_confirmation', as: 'quit_confirmation'
  get 'customers/:id', to: 'customers#show', as: 'customers_show'
  get 'home/about', to: 'homes#about', as: 'homes_about'
  get 'top', to: 'homes#top'
  resources :items
  resources :genres
  resources :orders, only: [:index, :show, :new, :thanks]
  resources :cart_items, only: [:index, :create]
  resources :addresses, only: [:index, :edit]
  resources :customers, only: [:show, :edit, :update, :destroy] do
    resources :addresses
    resources :orders
  member do
    get 'edit'
    patch 'update'
    get 'quit', to: 'customers#quit', as: 'quit_page'
    delete 'quit_destroy', to: 'customers#quit_destroy', as: 'quit_destroy'
  end
end


 resources :mypage, controller: 'customers', as: 'customers'
 resources :homes, only: [:index, :show, :new, :create, :edit, :update, :destroy]
 resources :addresses, only: [:index, :edit]

end
  # 管理者側のルーティング設定
devise_for :admin, skip: [:registrations, :passwords], controllers: {
  sessions: "admin/sessions"
}  
namespace :admin do
  get 'top', to: 'homes#top', as: 'top'
  resources :customers
  resources :genres
  resources :items
  resources :orders, only: [:show, :index]
  
  devise_scope :admin do
    get '/sign_out' => 'sessions#destroy'
  end
end
end