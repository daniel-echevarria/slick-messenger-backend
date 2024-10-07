class CreateConversations < ActiveRecord::Migration[7.2]
  def change
    create_table :conversations do |t|
      t.references :friendship, null: false, foreign_key: true

      t.timestamps
    end
  end
end