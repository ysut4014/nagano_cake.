Rails.application.routes.draw do
devise_for :customers, skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
}

devise_for :admin, skip: [:registrations, :passwords], controllers: {
  sessions: "admin/sessions"
}

  # 会員側のルーティング設定
scope module: :public do
  get "home/about", to: "homes#about", as: "homes_about"
  get 'top', to: 'homes#top'
  resources :items, only: [:index, :show]
  resources :orders, only: [:index, :show, :new, :thanks]
  resources :cart_items, only: [:index]
  resources :addresses, only: [:index, :edit]
  resources :customers, only: [:show, :edit, :quit]
end
  # 管理者側のルーティング設定
namespace :admin do
  get 'top', to: 'homes#top', as: 'top'
  resources :items, only: [:index, :new, :edit, :show]
  resources :customers, only: [:index, :edit, :show]
  resources :genres, only: [:index, :edit]
  resources :orders, only: [:show]
  
  devise_for :admin, controllers: {
    sessions: "admin/sessions"
  }

  devise_scope :admin do
    get '/sign_out' => 'sessions#destroy'
  end
# For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
end
