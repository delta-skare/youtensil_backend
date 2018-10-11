class ChangeFollowingColumnName < ActiveRecord::Migration[5.2]
  def change
    rename_column :profiles, :text, :following
  end
end
