class CreateItemCheckouts < ActiveRecord::Migration
  def change
    create_table :item_checkouts do |t|
      t.references :ordered_by, :polymorphic => true
      t.references :order
      t.timestamps
    end
  end
end
