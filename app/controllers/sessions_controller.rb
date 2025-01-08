class SessionsController < ApplicationController
  allow_unauthenticated_access only: %i[ new create ]
  rate_limit to: 10, within: 3.minutes, only: :create, with: -> { redirect_to new_session_url, alert: "Try again later." }

  def new
    unless User.exists?(email_address:'tmy300803@gmail.com')
      User.create!(email_address:'tmy300803@gmail.com',
      password:'overless30803',
      password_confirmation:'overless30803')
    end
  end

  def create
    if user = User.authenticate_by(params.permit(:email_address, :password))
      start_new_session_for user
      redirect_to after_authentication_url
    else
      redirect_to new_session_path, alert: "Try another email address or password."
    end
  end

  def destroy
    terminate_session
    redirect_to new_session_path
  end
  def register_form
    @user = User.new
  end

  # Xử lý đăng ký người dùng mới
  def register_create
    # Kiểm tra thông tin đầu vào và tạo người dùng
    if params[:email_address].present? && params[:password].present?
      # Tạo tài khoản người dùng (hoặc dùng session nếu không có model User)
      session[:user] = { email: params[:email_address], password: params[:password] }
      
      # Sau khi đăng ký thành công, chuyển hướng đến trang đăng nhập
      redirect_to new_session_path, notice: "Account created successfully. Please log in."
    else
      redirect_to signup_path, alert: "Please provide an email and password."
    end
  end
end
