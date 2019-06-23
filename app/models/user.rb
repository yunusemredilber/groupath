class User < ApplicationRecord
  has_secure_password

  validates :username,
            presence: true,
            uniqueness: {case_sensitive: false},
            length: {in: 3..12},
            format: {with: /\A[a-zA-Z][a-zA-Z0-9_-]*\Z/}
  validates :first_name,
            presence: true
  validates :last_name,
            presence: true
  validates :email,
            presence: true,
            uniqueness: {case_sensitive: false},
            email: true
  validates :password,
            presence: true,
            length: {maximum: 6}

end