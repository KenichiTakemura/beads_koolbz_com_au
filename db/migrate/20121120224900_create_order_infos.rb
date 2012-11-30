class CreateOrderInfos < ActiveRecord::Migration
  def change
    create_table :order_infos do |t|
      t.string :user_name
      t.string :email
      t.string :phone
      t.string :address
      t.text :body, :limit => Contact::DB_CONTACT_LENGTH
      t.references :order
      t.timestamps
    end
  end
end
