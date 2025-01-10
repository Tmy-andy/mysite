class User < ApplicationRecord
  has_secure_password
  has_many :sessions, dependent: :destroy

  normalizes :email_address, with: ->(e) { e.strip.downcase }

  validates :email_address, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP, message: "is not a valid email" }
  validates :password, presence: true, length: { minimum: 6 }

  # Phương thức xác thực người dùng
  def self.authenticate_by(credentials)
    user = find_by(email_address: credentials[:email_address]&.strip&.downcase)
    user if user&.authenticate(credentials[:password])
  end
end
