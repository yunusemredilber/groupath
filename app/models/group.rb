class Group < ApplicationRecord

  def to_param
    groupname
  end

end
