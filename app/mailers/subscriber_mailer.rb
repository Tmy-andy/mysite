class SubscriberMailer < ApplicationMailer
    default from: 'tmy300803@gmail.com'  # Địa chỉ email của bạn
  
    def welcome_email(subscriber)
      @subscriber = subscriber
      @product = subscriber.product  # Sử dụng @product để tạo một liên kết đến sản phẩm
      @url = 'http://example.com'   # Thay đổi URL cho phù hợp
      mail(to: @subscriber.email, subject: 'Thank you for subscribing!')
    end
  end
  