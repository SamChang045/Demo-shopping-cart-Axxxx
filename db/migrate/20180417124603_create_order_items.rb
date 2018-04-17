class CreateOrderItems < ActiveRecord::Migration[5.1]
  def change
    create_table :order_items do |t|
      t.integer :price
      t.integer :quantity
      t.integer :order_id
      t.integer :product_id, null: false
      t.timestamps
    end
  end
end
