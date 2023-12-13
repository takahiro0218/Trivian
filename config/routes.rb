Rails.application.routes.draw do

  # 顧客用
  # URL /users/sign_in ...
  devise_for :users, skip: [:passwords], controllers: {
    registrations: "users/registrations",
    sessions: 'public/sessions'
  }

  # 管理者用
  # URL /admin/sign_in ...
  devise_for :admin, skip: [:registrations, :passwords] , controllers: {
    sessions: "admin/sessions"
  }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html


  # 顧客側ルーティング
  scope module: :public do
    root to: "homes#top"
    get "about" => "homes#about"
    resources :users, only: [:show, :edit, :update, :destroy] do
      member do
        get "post_likes"
      end
      collection do
        get "check"
      end
      resources :relationships, only: [:create, :destroy]
      get 'followings' => 'relationships#followings', as: 'followings'
      get 'followers' => 'relationships#followers', as: 'followers'
    end
    resources :posts, only: [:new, :show, :create, :destroy] do
      collection do
        get "ranking"
      end
        resource :post_likes, only: [:create, :destroy]
        resources :post_comments, only: [:create, :destroy]
    end
    resources :notifications, only: [:index]
  end

  # 管理者側ルーティング
  namespace :admin do
    root to: "homes#top"
    resources :users, only: [:show, :edit, :update] do
      member do
        patch "ban"
      end
    end
    resources :posts, only: [:index, :show, :destroy]
    resources :categories, only: [:index, :create] do
      collection do
        get "edit"
        patch "update", as: :update
      end
    end
  end

  # 検索用ルーティング
  get "search" => "searches#search"
  get "search_result" => "searches#search_result"

  # ゲストログイン用のルーティング
  devise_scope :user do
    post 'users/guest_sign_in' => 'users/sessions#guest_sign_in'
  end


end


