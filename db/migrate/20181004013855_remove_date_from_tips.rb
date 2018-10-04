class RemoveDateFromTips < ActiveRecord::Migration[5.2]
  def change
    remove_column :tips, :date, :date
  end
end
