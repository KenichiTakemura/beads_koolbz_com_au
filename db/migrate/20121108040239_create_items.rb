class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.references :category
      t.integer :status
      t.integer :views, :default => 0
      t.string :barcode
      t.float :price_ex_gst
      t.float :gst
      t.float :price_inc_gst
      t.timestamp :barcode_ordered
      t.boolean :has_image, :default => false
      t.string :extra
      t.timestamps
    end
  end
end
