class ApplicationController < ActionController::Base
  include Authentication

  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  # Quản lý ngôn ngữ
  around_action :switch_locale

  # Thêm tham số `locale` vào tất cả các URL
  def default_url_options
    { locale: I18n.locale }.merge(super)
  end

  private

  # Xử lý thay đổi ngôn ngữ
  def switch_locale(&action)
    locale = params[:locale] || I18n.default_locale
    I18n.with_locale(locale, &action)
  end

  # Đặt lại session để đảm bảo an toàn
  def terminate_session
    reset_session # Xóa toàn bộ dữ liệu phiên
  end
end
