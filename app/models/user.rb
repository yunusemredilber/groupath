class User < ApplicationRecord
  has_secure_password

  def to_param
    username
  end

  has_many :comments, dependent: :destroy

  has_many :messages, dependent: :destroy

  has_many :memberships
  has_many :groups, through: :memberships

  has_many :followers,
           class_name: 'Follow',
           foreign_key: 'followed_id',
           dependent: :destroy
  has_many :follows,
           class_name: 'Follow',
           foreign_key: 'follower_id',
           dependent: :destroy

  validates :username,
            presence: true,
            uniqueness: { case_sensitive: false },
            length: { in: 3..12 },
            exclusion: {
                in: ['signin','signup','search','/','my_groups']
            }
  validates :first_name,
            presence: true
  validates :last_name,
            presence: true
  validates :email,
            presence: true,
            uniqueness: { case_sensitive: false },
            email: true
  validates :password,
            presence: true,
            length: { minimum: 6 }
  validates :channel,
            presence: true


end
