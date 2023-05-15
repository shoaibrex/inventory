class CreateLogs < ActiveRecord::Migration[5.2]
  def change
    create_table :logs do |t|
      t.integer :item_id
      t.integer :old_stock
      t.integer :new_stock
      t.string :action

      t.timestamps
    end
  end
end
