class CreateTips < ActiveRecord::Migration[5.2]
  def change
    create_table :tips do |t|
      t.text :restaurant
      t.text :food_type
      t.text :description
      t.date :date
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
