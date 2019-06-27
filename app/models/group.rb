class Group < ApplicationRecord

  has_many :memberships
  has_many :users, through: :memberships

  def to_param
    groupname
  end

end
