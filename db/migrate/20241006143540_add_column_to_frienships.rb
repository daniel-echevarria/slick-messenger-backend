class AddColumnToFrienships < ActiveRecord::Migration[7.2]
  def change
    add_reference :friendships, :first_user, null: false, foreign_key: { to_table: :users }
    add_reference :friendships, :second_user, null: false, foreign_key: { to_table: :users }
  end
end
