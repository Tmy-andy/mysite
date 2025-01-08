Rails.application.routes.draw do
  # Route GET cho form đăng ký
  get "register", to: "sessions#new", as: :new_register
  
  # Route POST cho việc tạo người dùng mới
  post "register", to: "sessions#create", as: :register
  
  resource :session
  resources :passwords, param: :token
  root "products#index"
  resources :products do
    resources :subscribers, only: [:create]
  end
  resource :unsubscribe, only: [:show]
end
