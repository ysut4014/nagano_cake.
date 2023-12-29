Rails.application.routes.draw do
  
    root 'public/homes#top'
devise_for :customers, skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
}



  # 会員側のルーティング設定
scope module: :public do
  get '/mypage', to: 'mypage#index', as: 'mypage'
  get 'orders/thanks', to: 'orders#thanks', as: 'orders_thanks'
  get 'customers/quit', to: 'customers#quit', as: 'customer_quit'
  get '/about', to: 'your_controller#your_action', as: 'about'
  patch 'customers/withdraw' => 'customers#withdraw', as: 'customers_withdraw'
  get 'quit' => 'customers#quit'
  get 'customers/:id', to: 'customers#show', as: 'customers_show'
  get 'home/about', to: 'homes#about', as: 'homes_about'
  get 'top', to: 'homes#top'
  resources :customers
  resources :items
  resources :genres
  resources :cart_items do
      delete :clear, on: :collection  # カートを空にするアクションに対するルートを追加
  end
  resources :orders do
    post 'confirm', on: :collection
    collection do
        delete 'destroy_all', to: 'orders#destroy_all', as: 'destroy_all'
  end
  resources :cart_items
      delete 'clear_cart', to: 'cart_items#clear_cart', as: 'clear_cart'

  resources :addresses
  resources :customers, only: [:show, :edit, :update, :destroy] do
    resources :addresses
    resources :orders
  member do
    get 'edit'
    patch 'update'
    get 'quit', to: 'customers#quit', as: 'quit_page'
    delete :quit_destroy
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
  resources :orders
  resources :customers
  resources :genres
  resources :items
  resources :addresses

  devise_scope :admin do
    get '/sign_out' => 'sessions#destroy'
  end
end
end
end