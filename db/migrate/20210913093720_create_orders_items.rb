class CreateOrdersItems < ActiveRecord::Migration[5.2]
  def change
    create_table :orders_items do |t|
      t.integer :order_id
      t.integer :item_id
      t.integer :unit_price
      t.integer :total_price

      t.timestamps
    end
  end
end
