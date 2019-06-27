class AddTitleToGroup < ActiveRecord::Migration[5.2]
  def change
    add_column :groups, :title, :string
  end
end
