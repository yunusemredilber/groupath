class CreateGroups < ActiveRecord::Migration[5.2]
  def change
    create_table :groups, force: true do |t|
      t.string :groupname, null:false
      t.string :description, null:false
      t.integer :admin_id, null:false

      t.timestamps
    end
    add_index :groups, :groupname, unique: true
  end
end
