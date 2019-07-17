class AddActiveToMembership < ActiveRecord::Migration[5.2]
  def change
    add_column :memberships, :active, :boolean, default: false
  end
end
