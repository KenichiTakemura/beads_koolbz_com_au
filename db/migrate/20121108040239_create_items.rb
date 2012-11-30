class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.references :category
      t.integer :status
      t.integer :open_status
      t.integer :views, :default => 0
      t.string :barcode
      t.float :price_ex_gst
      t.float :gst
      t.float :price_inc_gst
      t.datetime :barcode_ordered
      t.integer :write_at
      t.boolean :has_image, :default => false
      t.string :extra
      t.boolean :main, :default => false
      t.timestamps
    end
  end
end
