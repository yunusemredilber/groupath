class AddChannelToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :channel, :string
    add_index :users, :channel, unique: true
  end
end
