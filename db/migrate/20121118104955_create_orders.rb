class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.references :ordered_by, :polymorphic => true
      t.string :ordered_id
      t.integer :ordered_on
      t.float :ordered_price_ex_gst
      t.timestamps
    end
  end
end
