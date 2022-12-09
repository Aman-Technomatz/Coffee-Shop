class CreateItems < ActiveRecord::Migration[7.0]
  def change
    create_table :items do |t|
      t.string :name
      t.float :price
      t.boolean :availability
      t.references :tax_category, null: false, foreign_key: true

      t.timestamps
    end
  end
end
