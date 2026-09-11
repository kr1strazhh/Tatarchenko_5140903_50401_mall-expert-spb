class CreateEvaluations < ActiveRecord::Migration[8.0]
  def change
    create_table :evaluations do |t|
      t.references :user, null: false, foreign_key: true
      t.references :mall_item, null: false, foreign_key: true
      t.integer :rating, null: false
      t.text :comment

      t.timestamps
    end

    add_index :evaluations, [:user_id, :mall_item_id], unique: true
    add_check_constraint :evaluations, "rating >= 1 AND rating <= 100", name: "rating_range"
  end
end
