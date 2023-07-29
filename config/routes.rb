Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  # 管理者用
  # URL /admin/sign_in ...
  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: 'admin/sessions',
  }

  namespace :admin do
    get 'top' => 'homes#top', as: 'top'
    get 'search' => 'searches#search', as: 'search'
    resources :members, only: [:index, :show, :update]
    resources :tags, only: [:index, :create, :edit, :update]
    resources :spots, only: [:index, :show, :update]
  end

  # 顧客用
  # URL /members/sign_in ...
  devise_for :members, controllers: {
    registrations: 'public/registrations',
    sessions: 'public/sessions',
  }

  # guest用
  devise_scope :member do
    post "public/guest_sign_in", to: "public/sessions#guest_sign_in"
  end

  scope module: :public do
    root 'homes#top'
    get  '/about' => 'homes#about'
    # members/editのようにするとdeviseのルーティングとかぶってしまうためinformationを付け加えている。
    get 'members/information/edit' => 'members#edit', as: 'edit_information'
    patch 'members/information' => 'members#update', as: 'update_information'
    get "search" => "searches#search"

    resources :spots, only: [:new, :index, :show, :create, :edit, :update, :destroy] do
      resource :favorites, only: [:create, :destroy]
      resources :comments, only: [:create, :destroy]
    end

    resources :members, only: [:index, :show] do
      resource :relationships, only: [:create, :destroy]
      get 'followings' => 'relationships#followings', as: 'followings'
      get 'followers' => 'relationships#followers', as: 'followers'
    end
  end
end
