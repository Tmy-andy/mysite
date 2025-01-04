Rails.application.routes.draw do
  resource :session
  resources :passwords, param: :token
  # Đặt route gốc, trỏ về controller và action phù hợp
  root "products#index"
  resources :products
end


