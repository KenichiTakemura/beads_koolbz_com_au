class CreateItemHistories < ActiveRecord::Migration
  def change
    create_table :item_histories do |t|
      t.references :category
      t.references :order
      t.integer :status
      t.integer :order_count, :default => 1
      t.string :barcode
      t.float :price_ex_gst
      t.timestamp :barcode_ordered
      t.boolean :has_image, :default => false
      t.string :extra
      t.timestamps
    end
  end
end
