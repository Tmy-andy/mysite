class SubscribersController < ApplicationController
    allow_unauthenticated_access
    before_action :set_product
  
    def create
      @subscriber = @product.subscribers.where(subscriber_params).first_or_create

      if @subscriber.persisted?  # Kiểm tra nếu subscriber đã được lưu thành công
      # Gửi email chào mừng khi đăng ký thành công
        SubscriberMailer.welcome_email(@subscriber).deliver_later
        redirect_to @product, notice: "You are now subscribed."
      else
        redirect_to @product, alert: "Subscription failed."
      end
    end
  
    private
  
    def set_product
      @product = Product.find(params[:product_id])
    end
  
    def subscriber_params
      params.expect(subscriber: [ :email ])
    end
  end
  