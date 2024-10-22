class AddPhoneToProfiles < ActiveRecord::Migration[7.2]
  def change
    add_column :profiles, :phone, :string
  end
end
