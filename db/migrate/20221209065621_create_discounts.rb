class CreateDiscounts < ActiveRecord::Migration[7.0]
  def change
    create_table :discounts do |t|
      t.integer :base_item_id
      t.integer :child_item_id
      t.integer :base_item_quantity
      t.integer :child_item_quantity
      t.integer :discount_percent

      t.timestamps
    end
  end
end
