Rails.application.routes.draw do
  # Routes cho đăng ký người dùng
  get "register", to: "registrations#new", as: :new_register
  post "register", to: "registrations#create", as: :register

  # Routes cho session (login/logout)
  resource :session, only: [:new, :create, :destroy]

  # Routes cho quản lý mật khẩu
  resources :passwords, param: :token

  # Routes khác
  root "products#index"
  resources :products do
    resources :subscribers, only: [:create]
    resource :unsubscribe, only: [:show]
  end
end
