class CreateOrders < ActiveRecord::Migration[7.0]
  def change
    create_table :orders do |t|
      t.decimal :grand_total

      t.timestamps
    end
  end
end
