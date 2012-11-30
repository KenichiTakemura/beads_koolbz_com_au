class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :key
      t.string :name
      t.boolean :special
      t.string :headline
      t.string :leadline
      t.integer :open_status
      t.timestamps
    end
  end
end
