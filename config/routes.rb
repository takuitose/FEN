Rails.application.routes.draw do
# For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  # 管理者用
  # URL /admin/sign_in ...
  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }


  # 顧客用
  # URL /members/sign_in ...
  devise_for :members, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }
  # guest用
  devise_scope :member do
    post 'members/guest_sign_in', to: 'members/sessions#guest'
  end
  
  
  scope module: :public do
    root 'homes#top'
    get  '/about' => 'homes#about'
  end


end
