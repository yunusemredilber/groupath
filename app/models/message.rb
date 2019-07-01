class Message < ApplicationRecord

  has_many :comments, dependent: :destroy

  belongs_to :user
  validates :user, presence: true

  belongs_to :group
  validates :group, presence: true

  validates :text, length: { in: 10..3000 }

  validates :subject, inclusion: {
      in: ['General', 'Important', 'Help'],
      message: "%{value} is not a valid size"
  }
end
