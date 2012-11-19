class CreateCarousels < ActiveRecord::Migration
  def change
    create_table :carousels do |t|
      t.string :name
      t.boolean :has_image, :default => false
      t.string :headline
      t.string :leadline
      t.timestamps
    end
  end
end
