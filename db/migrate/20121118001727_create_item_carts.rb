class CreateItemCarts < ActiveRecord::Migration
  def change
    create_table :item_carts do |t|
      t.references :item
      t.references :item_checkout
      t.integer :order_count, :default => 1
      t.timestamps
    end
  end
end
