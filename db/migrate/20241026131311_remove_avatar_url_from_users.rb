class RemoveAvatarUrlFromUsers < ActiveRecord::Migration[7.2]
  def change
    remove_column :users, :avatar_url
  end
end
