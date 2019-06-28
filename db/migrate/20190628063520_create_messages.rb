class CreateMessages < ActiveRecord::Migration[5.2]
  def change
    create_table :messages do |t|
      t.string :subject, null: false
      t.string :text, null: false
      t.belongs_to :user, foreign_key: true

      t.timestamps
    end
  end
end
