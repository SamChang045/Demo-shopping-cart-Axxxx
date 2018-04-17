class CreateOrders < ActiveRecord::Migration[5.1]
  def change
    create_table :orders do |t|
      t.string  :name
      t.string  :address
      t.string  :payment_status
      t.string  :shipping_status
      t.string  :phone
      t.integer :aomount
      t.integer :sn 
      t.integer :user_id, null: false
      t.timestamps
    end
  end
end
