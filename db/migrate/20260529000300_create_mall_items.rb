class CreateMallItems < ActiveRecord::Migration[8.0]
  def change
    create_table :mall_items do |t|
      t.string :name_ru, null: false
      t.string :name_en, null: false
      t.text :description_ru, null: false
      t.text :description_en, null: false
      t.string :address_ru, null: false
      t.string :address_en, null: false
      t.string :image_url, null: false
      t.references :theme, null: false, foreign_key: true

      t.timestamps
    end

    add_index :mall_items, [:theme_id, :name_ru], unique: true
  end
end
