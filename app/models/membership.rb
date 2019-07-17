class Membership < ApplicationRecord
  belongs_to :user
  belongs_to :group

  #validates :active, presence: true
end
