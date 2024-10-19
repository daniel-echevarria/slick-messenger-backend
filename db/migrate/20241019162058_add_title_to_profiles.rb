class AddTitleToProfiles < ActiveRecord::Migration[7.2]
  def change
    add_column :profiles, :title, :string
  end
end
