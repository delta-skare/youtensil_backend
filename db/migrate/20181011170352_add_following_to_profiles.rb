class AddFollowingToProfiles < ActiveRecord::Migration[5.2]
  def change
    add_column :profiles, :text, :text
  end
end
