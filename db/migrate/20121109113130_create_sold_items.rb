class CreateSoldItems < ActiveRecord::Migration
  def change
    create_table :sold_items do |t|
      t.timestamp :sold_on
      t.integer :sold_at
      t.integer :sold_by
      t.float :price_ex_gst
      t.references :sold, :polymorphic => true
      t.timestamps
    end
  end
end
