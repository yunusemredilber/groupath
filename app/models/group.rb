class Group < ApplicationRecord

  has_many :messages, dependent: :destroy

  has_many :memberships, dependent: :destroy
  has_many :users, through: :memberships

  def to_param
    groupname
  end

end
