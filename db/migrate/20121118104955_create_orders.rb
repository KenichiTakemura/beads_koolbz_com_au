class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.references :ordered_by, :polymorphic => true
      t.timestamps
    end
  end
end
