class CreateItemsKeywords < ActiveRecord::Migration[5.2]
  def change
    create_table :items_keywords do |t|
      t.integer :item_id
      t.integer :keyword_id

      t.timestamps
    end
  end
end
