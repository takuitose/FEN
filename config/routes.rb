Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  # 管理者用
  # URL /admin/sign_in ...
  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: 'admin/sessions',
  }

  namespace :admin do
    get 'top' => 'homes#top', as: 'top'
    resources :tags, only: [:index, :create, :edit, :update]
  end

  # 顧客用
  # URL /members/sign_in ...
  devise_for :members, controllers: {
    registrations: 'public/registrations',
    sessions: 'public/sessions',
  }

  # guest用
  devise_scope :member do
  post 'public/guest_sign_in', to: 'public/sessions#guest_sign_in'
  end

  scope module: :public do
    root 'homes#top'
    get  '/about' => 'homes#about'
    get 'members/mypage' => 'members#show', as: 'mypage'
    # members/editのようにするとdeviseのルーティングとかぶってしまうためinformationを付け加えている。
    get 'members/information/edit' => 'members#edit', as: 'edit_information'
    patch 'members/information' => 'members#update', as: 'update_information'

    resources :spots, only: [:new, :index, :show, :create, :edit, :update, :destroy] do
      resource :favorites, only: [:create, :destroy]
    end
  end
end
