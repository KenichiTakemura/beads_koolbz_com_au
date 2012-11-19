class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :name
      t.boolean :special
      t.string :headline
      t.string :leadline
      t.timestamps
    end
  end
end
