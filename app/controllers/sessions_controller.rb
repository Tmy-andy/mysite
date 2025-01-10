class SessionsController < ApplicationController
  allow_unauthenticated_access only: [:new, :create, :register, :create_account]

  # Hiển thị form đăng nhập
  def new
    @user = User.new
  end

  # Đăng nhập
  def create
    user = User.authenticate_by(params.require(:user).permit(:email_address, :password))
  
    if user
      start_new_session_for(user)
      redirect_to root_path, notice: "Đăng nhập thành công!"
    else
      flash.now[:alert] = "Email hoặc mật khẩu không đúng."
      render :new
    end
  end  

  # Hiển thị form đăng ký
  def register
    @user = User.new
  end

  # Tạo tài khoản mới
  def create_account
    @user = User.new(user_params)
    if @user.save
      start_new_session_for(@user)
      redirect_to products_path, notice: "Tài khoản được tạo thành công và bạn đã đăng nhập!"
    else
      flash.now[:alert] = "Đăng ký thất bại. Vui lòng kiểm tra lại thông tin."
      render :register
    end
  end

  # Đăng xuất
  def destroy
    terminate_session
    redirect_to new_session_path, notice: "Đăng xuất thành công."
  end

  private

  def user_params
    params.require(:user).permit(:email_address, :password, :password_confirmation)
  end

  def terminate_session
    reset_session # Xóa toàn bộ dữ liệu phiên
  end
end
