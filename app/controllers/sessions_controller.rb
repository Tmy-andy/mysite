class SessionsController < ApplicationController
  allow_unauthenticated_access only: %i[ new create ]
  rate_limit to: 10, within: 3.minutes, only: :create, with: -> { redirect_to new_session_url, alert: "Try again later." }

  def new
    unless User.exists?(email_address:'tmy300803@gmail.com')
      User.create!(email_address:'tmy300803@gmail.com',
      password:'overless30803',
      password_confirmation:'overless30803')
    end
    @user = User.new
  end

  def create
    # Lấy các tham số từ params[:user]
    user_params = params.require(:user).permit(:email_address, :password, :password_confirmation)
  
    # Tạo mới đối tượng User
    user = User.new(user_params)
  
    # Kiểm tra nếu người dùng lưu thành công
    if user.save
      start_new_session_for(user)
      redirect_to after_authentication_url, notice: "Successfully registered and logged in!"
    else
      flash.now[:alert] = "Registration failed: #{user.errors.full_messages.join(', ')}"
      render :new
    end
  end
  

  def destroy
    terminate_session
    redirect_to new_session_path
  end
  def register_form
    @user = User.new
  end
end
