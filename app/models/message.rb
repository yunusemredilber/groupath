class Message < ApplicationRecord
  belongs_to :user
  validates :user, presence: true

  belongs_to :group
  validates :group, presence: true
end
