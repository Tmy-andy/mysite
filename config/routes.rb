Rails.application.routes.draw do
  resource :session
  resources :passwords, param: :token
  # Đặt route gốc, trỏ về controller và action phù hợp
  root "products#index"
  resources :products do
    resources :subscribers, only: [ :create ]
  end
  resource :unsubscribe, only: [ :show ]

end


