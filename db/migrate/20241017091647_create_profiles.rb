class CreateProfiles < ActiveRecord::Migration[7.2]
  def change
    create_table :profiles do |t|
      t.references :user, null: false, foreign_key: true
      t.string :picture
      t.string :name
      t.string :display_name
      t.string :email
      t.text :about

      t.timestamps
    end
  end
end
