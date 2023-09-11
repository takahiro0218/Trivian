Rails.application.routes.draw do
  namespace :admin do
    get 'categories/index'
    get 'categories/edit'
  end
  namespace :admin do
    get 'users/show'
    get 'users/edit'
  end
  namespace :admin do
    get 'posts/index'
    get 'posts/show'
  end
  namespace :admin do
    get 'homes/top'
  end
  namespace :public do
    get 'users/show'
    get 'users/edit'
    get 'users/check'
  end
  namespace :public do
    get 'posts/new'
    get 'posts/show'
  end
  namespace :public do
    get 'post_liks/index'
  end
  namespace :public do
    get 'homes/top'
    get 'homes/about'
  end
# 顧客用
# URL /users/sign_in ...
devise_for :users, skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
}

# 管理者用
# URL /admin/sign_in ...
devise_for :admin, skip: [:registrations, :passwords] , controllers: {
  sessions: "admin/sessions"
}
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
