class ChangeColumnName < ActiveRecord::Migration[5.2]
  def change
    rename_column :tips, :food_type, :food_types
  end
end
