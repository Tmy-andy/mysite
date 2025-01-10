Rails.application.routes.draw do
  scope "(:locale)", locale: /en|vn/ do
    # Routes cho session (login/logout)
    resource :session, only: [:new, :create, :destroy]

    # Trang đăng ký tài khoản
    get "register", to: "sessions#register", as: :register
    post "register", to: "sessions#create_account"

    # Routes khác
    root "products#index"
    resources :products do
      resources :subscribers, only: [:create]
      resource :unsubscribe, only: [:show]
    end
  end
end
