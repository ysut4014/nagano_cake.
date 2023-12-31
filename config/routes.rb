Rails.application.routes.draw do
  
    root 'public/homes#top'
devise_for :customers, skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
}



  # 会員側のルーティング設定
scope module: :public do
  delete 'quit_destroy' => 'customers#withdraw', as: 'quit_destroy'
  get 'home/about', to: 'homes#about', as: 'customer_homes_about'
  get 'top', to: 'homes#top', as: 'customer_homes_top'  
  get '/mypage', to: 'mypage#index', as: 'mypage'
  get 'orders/thanks', to: 'orders#thanks', as: 'orders_thanks'
  get 'customers/quit', to: 'customers#quit', as: 'customer_quit'
  patch 'customers/withdraw' => 'customers#withdraw', as: 'customers_withdraw'
  get 'quit' => 'customers#quit'
  get 'customers/:id', to: 'customers#show', as: 'customers_show'
  get 'home/about', to: 'homes#about', as: 'homes_about'
  get 'top', to: 'homes#top'
  resources :customers do
    resources :addresses
    resources :orders
  end
  resources :items
  resources :genres
  resources :orders, only: [:create, :new, :index, :show]
  resources :cart_items do
      delete :clear, on: :collection  # カートを空にするアクションに対するルートを追加
  end
  resources :addresses
  resources :orders do
    resources :customers, only: [:show]
    post 'confirm', on: :collection
    collection do
        delete 'destroy_all', to: 'orders#destroy_all', as: 'destroy_all'
  end
  
  resources :cart_items
     delete :clear, on: :collection



    resources :customers do
      resources :orders 
      resources :addresses

      member do
        get 'edit'
        patch 'update'
        get 'quit', to: 'customers#quit', as: 'quit_page'
        delete :quit_destroy
      end
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