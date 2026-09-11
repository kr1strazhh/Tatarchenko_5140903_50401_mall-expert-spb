class CreateThemes < ActiveRecord::Migration[8.0]
  def change
    create_table :themes do |t|
      t.string :name_ru, null: false
      t.string :name_en, null: false

      t.timestamps
    end

    add_index :themes, :name_ru, unique: true
    add_index :themes, :name_en, unique: true
  end
end
