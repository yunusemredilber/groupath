class User < ApplicationRecord
  has_secure_password

  def to_param
    username
  end


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
            length: {minimum: 6}


end
