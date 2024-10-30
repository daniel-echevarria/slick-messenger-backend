class RemovePictureFromProfiles < ActiveRecord::Migration[7.2]
  def change
    remove_column :profiles, :picture
  end
end
